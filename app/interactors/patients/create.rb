module Patients
  class Create
    include Interactor

    def call
      context.patient = Patient.new(context.patient_params)
      context.patient.patient_id = patient_id_hash.hashed_value

      context.patient.save!
    end

    private

    def patient_id
      context.patient_params[:patient_id]
    end

    def patient_id_hash
      return context.patient_id_hash if context.patient_id_hash

      context.patient_id_hash ||= 
        PatientIdHash.find_or_initialize_by(patient_id: patient_id) do |instance|
          instance.hashed_value = SecureRandom.uuid
          instance.save
        end
    end
  end
end