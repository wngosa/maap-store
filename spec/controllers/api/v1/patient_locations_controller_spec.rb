require 'rails_helper'

RSpec.describe Api::V1::PatientLocationsController, type: :controller do
  describe 'GET /patient_locations' do
    context 'with an unauthenticated user' do
      before { get :index }

      it 'should respond unauthorized' do
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with an authenticated user' do
      let(:user) { create :user }
      let!(:patient_locations) { create_list :patient_location, 10 }
      before do
        authenticate(user)
        get :index
      end

      it 'responds ok' do
        expect(response).to have_http_status(:ok)
      end

      it_behaves_like 'a paginated request', PatientLocation.all
    end
  end
end
