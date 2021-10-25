class Invoice < ApplicationRecord

  def amount
    total_amount / 100
  end
end
