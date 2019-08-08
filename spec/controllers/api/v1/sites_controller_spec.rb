require 'rails_helper'

RSpec.describe Api::V1::SitesController, type: :controller do
  describe 'GET /sites' do
    context 'with an unauthenticated user' do
      before { get :index }

      it 'should respond unauthorized' do
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with an authenticated user' do
      let(:user) { create :user }
      let!(:sites) { create_list :site, 10 }
      before do
        authenticate(user)
        post :index
      end

      it 'responds ok' do
        expect(response).to have_http_status(:ok)
      end

      it_behaves_like 'a paginated request', Site.all
    end
  end

  describe 'POST /sites' do
    context 'with an unauthenticated user' do
      before { post :create }

      it 'should respond unauthorized' do
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with an authenticated user' do
      before { authenticate(user) }
      let(:user) { create :user }

      it_behaves_like 'a create endpoint', Site, :create, :name
    end
  end
end
