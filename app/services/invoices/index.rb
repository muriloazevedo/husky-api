module Invoices
  class Index
    include ::Serializable
    include ::HasContract
    include ::Validations::Model

    serializer_class InvoiceSerializer
    contract_class Invoices::IndexContract

    def initialize(parameters)
      create_contract(parameters.to_h)
    end

    def call
      check_contract!
      process
    end

    def process
      params = contract.values
      invoices = Invoice.all
      invoices = invoices.by_due_date(params[:due_date])
      invoices = invoices.by_created_at(params[:created_at])
      invoices = invoices.by_number(params[:number])

      invoices
    end
  end
end
