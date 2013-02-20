FactoryGirl.define do
  factory :question do
    sequence(:id) { |n| n + 100 }
    title 'Fooness'
    explanation 'Fooness'
    possible_answers 'Foo'
  end

  factory :user do
    email "rod@foobar.com"
  end

  factory :badge do
    sequence(:id) { |n| n + 100 }
    name "foobar"
  end

end

