FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Person #{n}" }
    sequence(:email) { |n| "Person_#{n}@example.com" }
    password "foobar"
    password_confirmation "foobar"
    remember_token "Test Token"

    factory :admin do
      admin true
    end
  end

  factory :micropost do
    content "Lorem Ipsum"
    user
  end
end