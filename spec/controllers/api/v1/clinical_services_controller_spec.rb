require 'rails_helper'

RSpec.describe Api::V1::ClinicalServicesController, type: :controller do
  describe 'GET /clinical_services' do
    context 'with an unauthenticated user' do
      before { get :index }

      it 'should respond unauthorized' do
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with an authenticated user' do
      let(:user) { create :user }
      let!(:clinical_services) { create_list :clinical_service, 10 }
      before do
        authenticate(user)
        get :index
      end

      it 'responds ok' do
        expect(response).to have_http_status(:ok)
      end

      it_behaves_like 'a paginated request', ClinicalService.all
    end
  end
end
