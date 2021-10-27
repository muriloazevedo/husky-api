require 'rails_helper'

RSpec.describe Api::V1::InvoicesController, type: :controller do
  describe 'GET /v1/invoices' do
    let(:invoice) { create(:invoice) }
    let(:user) { create(:user) }
    
    before do
      auth_token = Auth::GenerateAuthToken.new(user).call
      headers = { Authorization: auth_token }
      @request.headers.merge! headers
    end

    describe '#show' do
      before do
        get :show, params: { id: invoice.id }
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

    describe '#index' do
      context 'on success' do
        let!(:invoices) { [create(:invoice), create(:invoice_murilo)] }
        before do
          get :index, as: :json
        end

        it 'returns 200' do
          expect(response).to have_http_status(:ok)
        end

        it 'returns multiple items' do
          expect(json_body[:results][:data].size).to be(2)
        end
      end
    end



    describe '#create' do
      before do
        post :create, params: params, as: :json
      end

      context 'on success' do

        let(:params) do
          {
            total_amount: 120_00,
            company: 'husky',
            billing: 'bla',
            email_list: 'muriloazevedo338@gmail.com;'
          }
        end

        it 'returns 201' do
          expect(response).to have_http_status(:created)
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

      context 'with error' do
        let(:params) do
          { "invoice": {} }
        end 

        it 'returns 400' do
          expect(response).to have_http_status(:bad_request)
        end
      end

      context 'with missing attributes' do
        let(:params) do
          { "invoice": { total_amount: 300_000 } }
        end

        it 'returns 422' do
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
  end
end

