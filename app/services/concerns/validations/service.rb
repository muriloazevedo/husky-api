# frozen_string_literal: true

module Validations
  module Service
    def check_service!
      raise(ValidationFailed.new(subject: self)) if invalid?
    end
  end
end
