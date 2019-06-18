require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  describe 'GET /me' do
    context 'with an unauthenticated user' do
      before { get :me }

      it 'should respond unauthorized' do
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with an authenticated user' do
      let(:user) { create :user }
      before do
        authenticate(user)
        get :me
      end

      it 'responds ok' do
        expect(response).to have_http_status(:ok)
      end

      it 'responds with the current user info' do
        expect(response_body).to eq(UserSerializer.new(user).serializable_hash)
      end
    end
  end
end
