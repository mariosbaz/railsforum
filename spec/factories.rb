require 'faker'

FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password "foobar"
    password_confirmation "foobar"

    factory :testuser do
      email "testuser@example.com"
      password "foobar"
      password_confirmation "foobar"
    end
  end

  factory :topic do
    name { Faker::Name.first_name }
    user

    factory :invalid_topic do
      name nil
    end
  end

  factory :post do
    content { Faker::Lorem.paragraph }
    user
    topic
    score "0"

    factory :invalid_post do
      content nil
    end
  end

  factory :vote do
    vote_value "1"
    user
    post  

    factory :invalid_vote do
      vote_value nil
    end
  end
end