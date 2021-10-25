# frozen_string_literal: true

module Invoices
  class CreateContract < Dry::Validation::Contract
    params do
      required(:total_amount).value(:integer)
      required(:billing).value(:string)
      required(:company).value(:string)
      required(:email_list).value(:string)
    end
  end
end
