require 'rails_helper'
include ApplicationHelper

RSpec.describe "ApplicationHelper", type: :helper do
  it "loads JSON from Active Storage attachment" do
    file = Rails.root.join('app/helpers/application_helper.rb').to_s
    l = create(:lab_record_import)
    l.rows_file.attach(io: File.open(DUMMY_JSON), filename: "rows_file.json")

    json_content = json_from_active_storage_attachment(l.rows_file.blob.key)

    expect(json_content).to eq(open(DUMMY_JSON, 'r') { |file| JSON.load(file) })
  end
end
