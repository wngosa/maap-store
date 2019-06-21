require 'rails_helper'

RSpec.describe Api::V1::LabsController, type: :controller do
  describe 'GET /labs' do
    context 'with an unauthenticated user' do
      before { get :index }

      it 'should respond unauthorized' do
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with an authenticated user' do
      let(:user) { create :user }
      let!(:labs) { create_list :lab, 10 }
      before do
        authenticate(user)
        get :index
      end

      it 'responds ok' do
        expect(response).to have_http_status(:ok)
      end

      it_behaves_like 'a paginated request', Lab.all
    end
  end
end
