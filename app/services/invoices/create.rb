module Invoices
  class Create
    include ::Serializable
    include ::HasContract
    include ::Validations::Model

    serializer_class InvoiceSerializer
    contract_class Invoices::CreateContract

    INVOICE_NUMBER_DIGITS = 100_000

    def initialize(parameters)
      create_contract(parameters.to_h)
    end

    def call
      check_contract!
      check_model!
      process
    end

    def process
      create_invoice_number!
      ActiveRecord::Base.transaction do
        invoice.save!
      end
    end

    def invoice
      @invoice ||= Invoice.new(contract.values)
    end

    alias model invoice
    alias serializable_object invoice

    private

    def create_invoice_number!
      while
        invoice.number = SecureRandom.random_number(INVOICE_NUMBER_DIGITS).to_s.rjust(5, '0')

        break unless Invoice.exists?(number: invoice.number)
      end
    end
  end
end
