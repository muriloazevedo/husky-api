# frozen_string_literal: true

module HasContract
  include Validations::Contract

  def create_contract(parameters)
    @contract = setted_contract_class.new.call(parameters)
  end

  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def contract_class(contract_class)
      send(:define_method, :setted_contract_class) { contract_class }
    end
  end

  private

  attr_accessor :contract
end
