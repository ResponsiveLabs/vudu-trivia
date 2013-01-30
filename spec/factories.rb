FactoryGirl.define do
  factory :question do
    sequence(:id) { |n| n + 100 }
  end

  factory :user do
    email "rod@foobar.com"
    game
  end

  factory :game do
    question
    user
  end
end

