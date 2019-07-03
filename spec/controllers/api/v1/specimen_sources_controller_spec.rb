require 'rails_helper'

RSpec.describe Api::V1::SpecimenSourcesController, type: :controller do
  describe 'GET /specimen_sources' do
    context 'with an unauthenticated user' do
      before { get :index }

      it 'should respond unauthorized' do
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with an authenticated user' do
      let(:user) { create :user }
      let!(:labs) { create_list :specimen_source, 10 }
      before do
        authenticate(user)
        get :index
      end

      it 'responds ok' do
        expect(response).to have_http_status(:ok)
      end

      it_behaves_like 'a paginated request', SpecimenSource.all
    end
  end
end
