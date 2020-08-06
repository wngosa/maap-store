require 'rails_helper'

RSpec.describe Api::V1::LabRecordImportsController, type: :controller do
  let(:site) { create(:site) }
  context 'create lab records' do
    before do
      allow(AnonymizeLabRecordImportWorker).to receive(:perform_async)
      post :create, params: { site_id: site.id }
    end
    it 'returns id and timestamps as JSON' do
      json_response = JSON.parse(response.body)
      l = LabRecordImport.first

      expect(json_response).to eq(
        'id' => l.id,
        'created_at' => l.created_at.to_json.undump,
        'updated_at' => l.updated_at.to_json.undump
      )
    end
  end
end
