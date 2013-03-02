FactoryGirl.define do
  factory :errand do
    source_place
    arrival_place
  end

  factory :place, :aliases => [:source_place, :arrival_place] do
    city { Faker::Address.city }
    state { Faker::Address.state }
    country { Faker::Address.country }
    postal_code { Faker::Address.postcode }
  end
end
