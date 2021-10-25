module Api
  module V1
    class InvoicesController < ApplicationController

      def index
        invoices = Invoice.all
        invoices = invoices.by_due_date(params[:due_date]) if params[:due_date].present?
        invoices = invoices.by_created_at(params[:created_at]) if params[:created_at].present?
        invoices = invoices.where(number: params[:number]) if params[:number].present?
        render json: { results: InvoiceSerializer.new(invoices).as_json }, status: :ok
      end

      def create
        service = Invoices::Create.new(invoice_params)
        service.call

        render json: service, status: :created
      end

      def show
        service = Invoices::Show.new({id: params[:id]})
        service.call

        render json: service, status: :ok
      end

      def send_invoice
        service = Invoices::Send.new({ id: params[:id] })
        service.call

        render json: service, status: :ok
      end

      private

      def invoice_params
        params.require(:invoice).permit(:total_amount, :company, :billing, :email_list)
      end
    end
  end
end
