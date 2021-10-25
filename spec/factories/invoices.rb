FactoryBot.define do
  factory :invoice do
    total_amount { 12000 }
    company { "husky"}
    billing { "bla" }
    email_list { "muriloazevedo338@gmail.com;" }
    number { SecureRandom.random_number(100_000).to_s.rjust(5, '0') }
    due_date { Time.current + 2.days }
  end
end
