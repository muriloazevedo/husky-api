# frozen_string_literal: true

class ErrorsSerializer
  def initialize(object)
    @object = object
  end

  def as_json(_options = nil)
    { errors: parsed_errors }
  end

  private

  def parsed_errors
    case @object
    when ActiveModel::Validations
      model_errors
    when Dry::Validation::Result
      contract_errors
    end
  end

  def contract_errors
    @object.errors.group_by(&:path).map do |path, messages|
      {
        source: path.join('.'),
        detail: messages.map(&:text).to_sentence
      }
    end
  end

  def model_errors
    @object.errors.messages.map do |attribute, message|
      {
        source: attribute,
        detail: message.to_sentence
      }
    end
  end
end
