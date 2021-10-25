# frozen_string_literal: true

module Validations
  module Contract
    def check_contract!
      raise(ValidationFailed.new(subject: contract)) if contract.failure?
    end
  end
end
