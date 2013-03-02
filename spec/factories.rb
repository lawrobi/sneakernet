FactoryGirl.define do
  factory :errand do
    source_place
    arrival_place
    assignee
    requester
  end

  factory :place, :aliases => [:source_place, :arrival_place] do
    city { Faker::Address.city }
    state { Faker::Address.state }
    country { Faker::Address.country }
    postal_code { Faker::Address.postcode }
    display_name { "#{city}, #{state}" }
  end

  factory :user, :aliases => [:assignee, :requester] do
    name { Faker::Name.name }
    password "Blueberry23"
    password_confirmation "Blueberry23"
    email { Faker::Internet.email(name) }
  end
end
