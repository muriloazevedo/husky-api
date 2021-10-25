# frozen_string_literal: true

module Invoices
  class IndexContract < Dry::Validation::Contract
    params do
      optional(:due_date).value(:string)
      optional(:created_at).value(:string)
      optional(:number).value(:string)
    end
  end
end
