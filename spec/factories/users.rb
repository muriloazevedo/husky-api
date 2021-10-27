FactoryBot.define do
  factory :user do
    email { 'muriloazevedo338@gmail.com'}
    login_token_verified_at { Time.now }
  end
end
