module Api
  module V1
    class InvoicesController < ApplicationController
      before_action :authenticate_request!

      def index
        invoices = Invoices::Index.new(params.permit!.to_h).call
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
        params.require(:invoice).permit(:total_amount, :company, :billing, :email_list, :due_date)
      end
    end
  end
end
