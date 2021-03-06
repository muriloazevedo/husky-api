FactoryBot.define do
  factory :invoice do
    total_amount { 12000 }
    company { "husky"}
    billing { "bla" }
    email_list { "muriloazevedo338@gmail.com;" }
    number { SecureRandom.random_number(100_000).to_s.rjust(5, '0') }
    due_date { Time.current + 2.days }
  end

  factory :invoice_murilo, class: Invoice do
    total_amount { 14000 }
    company { "husky"}
    billing { "murilo" }
    email_list { "joe@gmail.com;" }
    number { SecureRandom.random_number(100_000).to_s.rjust(5, '0') }
    due_date { Time.current + 2.days }
  end
end
