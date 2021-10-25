module Api
  module V1
    class InvoicesController < ApplicationController

      def index
        invoices = Invoice.all
        invoices = invoices.map do |invoice|
          { id: invoice.id, total_amount: invoice.total_amount }
        end
        render json: { results: invoices }.to_json, status: :ok
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

      def send
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
