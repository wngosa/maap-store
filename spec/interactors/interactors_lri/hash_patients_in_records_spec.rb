require 'rails_helper'

RSpec.describe InteractorsLRI::HashPatientsInRecords, type: :interactor do
  it "lab records start in a pending state " do
    expect(lri_with_lab_records(2).lab_records.map &:patient_id_state).to eq(["pending", "pending"])
  end

  it "hashes patient_ids in lab records" do
    lab_record_import = lri_with_lab_records(2)
    previous_lrs = lab_record_import.lab_records.map do |lr| 
      OpenStruct.new(:id => lr.id, :patient_id => lr.patient_id)
    end

    InteractorsLRI::HashPatientsInRecords.call(record: lab_record_import)

    (lab_record_import.reload.lab_records).zip(previous_lrs) do |current, pre|
      expect(current.id).to eq(pre.id)
      expect(current.patient_id_state).to eq("obfuscated")
      expect(current.patient_id).not_to eq(pre.patient_id)
    end
  end

  it "creates a patient id hash for each obfuscated patient" do
    lab_record_import = lri_with_lab_records(2)
    previous_lrs = lab_record_import.lab_records.map do |lr| 
      OpenStruct.new(:id => lr.id, :patient_id => lr.patient_id)
    end.sort_by &:patient_id
    previous_count = PatientIdHash.count

    InteractorsLRI::HashPatientsInRecords.call(record: lab_record_import)

    expect(PatientIdHash.count).to eq(previous_count + 2)
    PatientIdHash.all.order(:patient_id).zip(previous_lrs) do |hash, lr|
      expect(hash.patient_id).to eq(lr.patient_id)
    end
  end
end
