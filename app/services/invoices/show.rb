module Invoices
  class Show
    include ::Serializable
    include ::HasContract
    include ::Validations::Model

    serializer_class InvoiceSerializer
    contract_class Invoices::ShowContract

    def initialize(parameters)
      create_contract(parameters.to_h)
    end

    def call
      check_contract!
      check_model!
      process
    end

    def process
      invoice
    end

    def invoice
      @invoice ||= Invoice.find(contract.values[:id])
    end

    alias model invoice
    alias serializable_object invoice
  end
end
