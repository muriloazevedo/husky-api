# frozen_string_literal: true

module Validations
  module Model
    def check_model!
      raise(ValidationFailed.new(subject: model)) if model.invalid?
    end
  end
end
