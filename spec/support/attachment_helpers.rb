module AttachmentHelpers
  def with_rows_file_attached(lab_record_import, rows)
    Tempfile.open('rows_file.json') do |rows_file|
      rows_file.write(rows.to_json)
      rows_file.rewind
      lab_record_import.rows_file.attach(io: rows_file, filename: "rows_file.json", content_type: "application/json")
      yield 
    end
  end
end

RSpec.configure do |config|
  config.include AttachmentHelpers
end
