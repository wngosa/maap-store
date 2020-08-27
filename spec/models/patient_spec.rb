require 'rails_helper'

RSpec.describe Patient, type: :model do
  describe 'patient_id_hash_for' do
    it "creates a patient id hash if there isn't any entry for the given patient_id" do
      site = create(:site)
      previous_count = PatientIdHash.count

      hashed_value = Patient.patient_id_hash_for('New Patient', site.id)

      expect(PatientIdHash.count).to eq(previous_count + 1)
      expect(PatientIdHash.first.patient_id).to eq('New Patient')
      expect(PatientIdHash.first.hashed_value).to eq(hashed_value)
    end

    it "doesn't create a patient id hash if there is an existing entry for the given patient_id" do
      site = create(:site)
      existing_patient_id = 'Existing Patient'
      existing_hashed_value = SecureRandom.uuid
      create(:patient_id_hash, patient_id: existing_patient_id, hashed_value: existing_hashed_value, site: site)
      previous_count = PatientIdHash.count

      Patient.patient_id_hash_for(existing_patient_id, site.id)

      expect(PatientIdHash.count).to eq(previous_count)
      expect(PatientIdHash.first.patient_id).to eq(existing_patient_id)
      expect(PatientIdHash.first.hashed_value).to eq(existing_hashed_value)
    end

    it 'is scoped by site: creates a patient when patient_id is the same but site is different' do
      site1 = create(:site)
      site2 = create(:site)
      matching_patient_id = 'Matching Patient'
      existing_hashed_value = SecureRandom.uuid
      create(:patient_id_hash, patient_id: matching_patient_id, hashed_value: existing_hashed_value, site: site1)
      previous_count = PatientIdHash.count

      Patient.patient_id_hash_for(matching_patient_id, site2.id)

      expect(PatientIdHash.count).to eq(previous_count + 1)
      expect(PatientIdHash.last.site.id).to eq(site2.id)
      expect(PatientIdHash.last.patient_id).to eq(matching_patient_id)
      expect(PatientIdHash.last.hashed_value).not_to eq(existing_hashed_value)
    end
  end
end
