# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Seed US cities to places table
require 'csv'
file = File.join(Rails.root, 'config', 'data', 'us_cities_by_population.csv')
cities = CSV.read(file)
cities.each do |city|
  place = Place.find_or_initialize_by_city_and_state(city[0], city[1])
  place.country = "United States"
  place.display_name = "#{place.city}, #{place.state}"
  place.population = city[2].to_i
  place.save
end

# world cities
file = File.join(Rails.root, 'config', 'data', 'world_cities_with_population.tsv')
cities = CSV.read(file, { :col_sep => "\t" })
cities.reject {|c| c[4].match("United States")}.each do |city|
  place = Place.find_or_initialize_by_city_and_country(city[2], city[4])
  place.display_name = "#{place.city}, #{place.country}"
  place.population = city[3].gsub(/\s/, "").to_i
  place.save
end

# users
avatar_filenames = Dir[Rails.root.join("public", "avatars", "*")].map do |p|
  File.basename(p)
end

remaining_user_count = 124 - User.count
top_places = Place.where(:country => "United States").order("population desc").take(40)
top_places += Place.where("country != 'United States'").order("population desc").take(15)
sf = Place.where(:city => "San Francisco", :state => "CA").first

city_coords = {}

top_places.each do |city|
  while city_coords[city.id].nil?
    city_coords[city.id] = Geocoder.coordinates(city.display_name)
    sleep 0.1
  end
end

5.times { top_places << sf }

remaining_user_count.times do |i|
  u = FactoryGirl.build(:user,
    :image_url => "http://www.bringmystuff.net/avatars/#{avatar_filenames[i]}",     :home_place => top_places.sample)
  u.created_at = Time.now - rand(30).days - rand(10000).seconds - 10.days
  u.last_sign_in_at = u.created_at + rand(10).day + rand(10000).seconds
  u.sign_in_count = rand(20)
  u.save
end

# errands
remaining_errand_count = 600 - Errand.count
remaining_errand_count.times do |i|
  source_place = top_places.sample
  arrival_place = top_places.sample
  distance = Geocoder::Calculations.distance_between(city_coords[source_place.id], city_coords[arrival_place.id]).to_i
  e = FactoryGirl.create(:errand, :source_place => source_place,
                     :arrival_place => arrival_place,
                     :distance => distance,
                     :requester => User.all.sample,
                     :deadline => Time.now + rand(1000000).seconds)
  num_offers = rand(4)
  num_offers.times do |i|
    status = (i == num_offers - 1 && num_offers % 2 == 1 ? "completed" : "pending")
    if status == "completed"
      e.deadline = Time.now - rand(10000000).seconds
      e.save
    end
    leaving_at = e.deadline - rand(1000000)
    arriving_at = leaving_at + rand(1000000)
    FactoryGirl.create(:errand_offer, :errand => e, :courier => User.all.sample,
      :bid => (e.distance / 10.0).to_i + (rand(10) * 10),
      :status => status)
  end
end

# offers
remaining_offer_count = 600 - Offer.count

remaining_offer_count.times do |i|
  leaving_at = Time.now + rand(10000000).seconds
  arriving_at = leaving_at + rand(1000000)
  FactoryGirl.create(:offer, :courier => User.all.sample,
                     :source_place => top_places.sample,
                     :arrival_place => top_places.sample,
                     :leaving_at => leaving_at, :arriving_at => arriving_at)
end
