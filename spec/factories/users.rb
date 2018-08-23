FactoryGirl.define do
  factory :user do
    email {Faker::Internet.email}
    password "estoril"
    password_confirmation "estoril"
  end
end
