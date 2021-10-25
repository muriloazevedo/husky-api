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
    end
  end
end
