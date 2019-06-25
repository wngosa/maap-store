require 'rails_helper'

RSpec.describe Api::V1::SessionsController, type: :controller do
  describe 'GET /sign_in' do
    before { @request.env['devise.mapping'] = Devise.mappings[:user] }
    context 'without user credentials' do
      before { post :create }

      it 'should respond unauthorized' do
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with valid user credentials' do
      let!(:user) { create(:user, password: password, email: email) }
      let(:password) { 'password' }
      let(:email) { 'email@email.tld' }
      before { post :create, params: { email: email, password: password } }

      it 'responds ok' do
        expect(response).to have_http_status(:ok)
      end

      it 'responds with the current user info' do
        expect(response_body.keys).to eq(%i[access-token token-type
                                            client expiry uid])
      end
    end
  end
end
