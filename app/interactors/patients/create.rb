module Patients
  class Create
    include Interactor

    def call
      context.patient = Patient.new(context.patient_params)
      context.patient.patient_id = patient_id_hash&.hashed_value || patient_id

      context.patient.save!
    end

    private

    def patient_id
      context.patient_params[:patient_id]
    end

    def patient_id_hash
      return context.patient_id_hash if context.patient_id_hash

      context.patient_id_hash ||= PatientIdHash.find_by(patient_id: patient_id)
    end
  end
end