# Preview all emails at http://localhost:3000/rails/mailers/invoice
class InvoicePreview < ActionMailer::Preview

  def send_invoice
    invoice = Invoice.first
    InvoiceMailer.with(invoice: invoice).send_invoice
  end

end
