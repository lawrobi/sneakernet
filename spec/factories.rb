FactoryGirl.define do
  factory :errand do
    source_place
    arrival_place
    assignee
    requester
    size { ["envelope", "cookbook", "toaster", "microwave", "oven"].sample }
  end

  factory :offer do
    source_place
    arrival_place
    courier
    size { ["envelope", "cookbook", "toaster", "microwave", "oven"].sample }
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
