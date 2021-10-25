require 'rails_helper'

RSpec.describe Api::V1::InvoicesController, type: :request do
  describe 'GET /v1/invoices/:id' do
    let(:invoice) { create(:invoice) }

    describe '#create' do
      before do
        get "/v1/invoices/#{invoice.id}"
      end

      context 'on success' do  
        it 'returns 201' do
          expect(response).to have_http_status(:ok)
        end
      end
    end
  end
end

