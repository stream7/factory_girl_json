FactoryGirl.define do
  factory :user do
    sequence(:name) {|n| "user name #{n}"}
    sequence(:email) {|n| "useremail#{n}@email.com"}
    age 12
  end

  factory :user_with_posts, parent: :user, json_serializer: UserSerializer do
    after(:create) do |user|
      create :post, user: user
    end
  end
end
