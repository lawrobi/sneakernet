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
  place.save
end

# world cities
file = File.join(Rails.root, 'config', 'data', 'world_cities.csv')
cities = CSV.read(file)
cities.reject {|c| c[1] == "United States"}.each do |city|
  place = Place.find_or_initialize_by_city_and_country(city[2], city[1])
  place.display_name = "#{place.city}, #{place.country}"
  place.save
end
