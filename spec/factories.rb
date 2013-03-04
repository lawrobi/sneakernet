FactoryGirl.define do
  factory :errand do
    source_place
    arrival_place
    requester
    estimated_price { 50 + rand(300)}
    distance { rand(5000) }
    size { ["envelope", "cookbook", "toaster", "microwave", "oven"].sample }
    summary { ["Documents, large envelop",
               "plazma TV panel",
               "USB flash card with secret data", "Bottle of wine",
               "Candlesticks",
               "Tea set, flatware",
               "20 T-shirts",
               "Spare tire",
               "A box of organic apples",
               "6 pack of Bud light",
               "Keys",
               "Organic milk 3 boxes",
               "Bottle of rum",
               "Collectable posters",
               "Box of cigars",
               "2 cats",
               "A dog",
               "Samples"].sample }
  end

  factory :errand_offer do
    errand
    courier
  end

  factory :offer do
    source_place
    arrival_place
    courier
    size { ["envelope", "cookbook", "toaster", "microwave", "oven"].sample }
    summary { ["Documents, large envelop",
               "plazma TV panel",
               "USB flash card with secret data", "Bottle of wine",
               "Candlesticks",
                "Tea set, flatware",
                "20 T-shirts",
                "Spare tire",
                "A box of organic apples",
                "6 pack of Bud light",
                "Keys",
                "Organic milk 3 boxes",
                "Bottle of rum",
                "Collectable posters",
                "Box of cigars",
                "2 cats",
                "A dog",
                "Samples"].sample }
  end

  factory :message do
    subject { Faker::Lorem.sentence }
    body { Faker::Lorem.paragraph }
    read_status { ["read", "unread", "deleted"].sample }
    from_user
    to_user
  end

  factory :place, :aliases => [:source_place, :arrival_place] do
    city { Faker::Address.city }
    state { Faker::Address.state }
    country { Faker::Address.country }
    postal_code { Faker::Address.postcode }
    display_name { "#{city}, #{state}" }
  end

  factory :user, :aliases => [:assignee, :requester, :from_user, :to_user,
                              :courier] do
    name { Faker::Name.name }
    password "Blueberry23"
    password_confirmation "Blueberry23"
    email { Faker::Internet.email(name) }
  end
end
