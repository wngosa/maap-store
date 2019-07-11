require 'rails_helper'

RSpec.describe Api::V1::AntibioticConsumptionStatsController, type: :controller do # rubocop:disable Metrics/LineLength
  describe 'GET /antibiotic_consumption_stats' do
    context 'with an unauthenticated user' do
      before { get :index }

      it 'should respond unauthorized' do
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with an authenticated user' do
      let(:user) { create :user }
      let!(:antibiotic_consumption_stats) do
        create_list :antibiotic_consumption_stat, 10
      end
      before do
        authenticate(user)
        get :index
      end

      it 'responds ok' do
        expect(response).to have_http_status(:ok)
      end

      it_behaves_like 'a paginated request', AntibioticConsumptionStat.all
    end
  end
end
