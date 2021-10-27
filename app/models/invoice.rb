class Invoice < ApplicationRecord
  scope :by_number, ->(number){ where(number: number) }

  scope :by_created_at, lambda { |date|
    return unless date

    date = DateTime.parse(date)
    where(created_at: date.midnight..date.end_of_day)
  }

  scope :by_due_date, lambda { |date|
    return unless date

    date = DateTime.parse(date)
    where(due_date: date.midnight..date.end_of_day)
  }

  scope :by_number, lambda { |number|
    where(number: number[:number]) if number[:number]
  }

  def amount
    total_amount / 100
  end
end
