class InvoiceSerializer
  include FastJsonapi::ObjectSerializer

  set_type :invoice

  attributes :id, :total_amount, :number, :due_date, :created_at, :updated_at
end
