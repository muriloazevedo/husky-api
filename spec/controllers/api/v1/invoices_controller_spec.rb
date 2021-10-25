require 'rails_helper'

RSpec.describe Api::V1::InvoicesController, type: :request do
  describe 'GET /v1/invoices/:id' do
    let(:invoice) { create(:invoice) }

    describe '#create' do
      before do
        get "/v1/invoices/#{invoice.id}", as: :json
      end

      context 'on success' do  
        it 'returns 201' do
          expect(response).to have_http_status(:ok)
        end

        it 'returns correct type' do
          expect(json_body[:data][:type]).to eq('invoice')
        end

        it 'returns correct attributes' do
          expect(json_body[:data][:attributes].keys).to contain_exactly(
            *InvoiceSerializer.attributes_to_serialize.keys
          )
        end
      end
    end
  end
end

