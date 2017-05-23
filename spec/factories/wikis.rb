FactoryGirl.define do
  factory :wiki do
    title Faker::ChuckNorris.fact
    body Faker::ChuckNorris.fact
    private false
    user nil
  end
end
