class InvoiceSerializer
  include FastJsonapi::ObjectSerializer

  set_type :invoice

  attributes :id, :total_amount
end
