class InvoiceMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def send_invoice
    @invoice = params[:invoice]
    email_list = @invoice.email_list.split(';')
    email_list.each do |email|
      mail(to: email, subject: 'Your invoice')
    end
  end
end
