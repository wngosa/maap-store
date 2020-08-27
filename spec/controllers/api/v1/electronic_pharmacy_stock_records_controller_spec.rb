require 'rails_helper'

RSpec.describe Api::V1::ElectronicPharmacyStockRecordsController, type: :controller do
  let(:site) { create(:site) }
  context 'create electronic pharmacy stock records' do
    before do
      allow(AnonymizeElectronicPharmacyStockRecordWorker).to receive(:perform_async)
    end
    it 'returns id and timestamps as JSON' do
      post :create, params: { site_id: site.id }

      json_response = JSON.parse(response.body)
      e = ElectronicPharmacyStockRecord.first

      expect(json_response).to eq(
        'id' => e.id,
        'created_at' => e.created_at.to_json.undump,
        'updated_at' => e.updated_at.to_json.undump
      )
    end
  end
end
