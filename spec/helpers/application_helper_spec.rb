require 'rails_helper'
include ApplicationHelper

RSpec.describe "ApplicationHelper", type: :helper do
  it "loads JSON from Active Storage attachment" do
    Tempfile.open('json_example') do |f|
      initial_content = { "some_test_json" => true }
      l = create(:lab_record_import)
      f.write(initial_content.to_json)
      f.rewind
      l.rows_file.attach(io: f, filename: "rows_file.json", content_type: "application/json")

      json_content = json_from_active_storage_attachment(l.rows_file.blob.key)

      expect(json_content).to eq(initial_content)
    end
  end
end
