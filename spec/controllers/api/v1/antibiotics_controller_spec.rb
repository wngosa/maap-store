require 'rails_helper'

RSpec.describe Api::V1::AntibioticsController, type: :controller do
  describe 'GET /antibiotics' do
    context 'with an unauthenticated user' do
      before { get :index }

      it 'should respond unauthorized' do
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with an authenticated user' do
      let(:user) { create :user }
      let!(:antibiotics) do
        create_list :antibiotic, 10
      end
      before do
        authenticate(user)
        get :index
      end

      it 'responds ok' do
        expect(response).to have_http_status(:ok)
      end

      it_behaves_like 'a paginated request', Antibiotic.all
    end
  end

  describe 'POST /antibiotics' do
    context 'with an unauthenticated user' do
      before { post :create }

      it 'should respond unauthorized' do
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with an authenticated user' do
      before { authenticate(user) }
      let(:user) { create :user }

      it_behaves_like 'a create endpoint', Antibiotic, :create, :name
    end
  end
end
