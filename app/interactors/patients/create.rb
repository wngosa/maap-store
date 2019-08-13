module Patients
  class Create
    include Interactor

    def call
      context.patient = Patient.find_or_initialize_by(patient_id: patient_id_hash)
      return if context.patient.persisted?

      context.patient.assign_attributes(context.patient_params)

      context.patient.save!
    end

    private

    def site_id
      context.patient_params[:site_id]
    end

    def patient_id
      context.patient_params[:patient_id]
    end

    def patient_id_hash
      return context.patient_id_hash if context.patient_id_hash

      context.patient_id_hash ||=
        PatientIdHash.find_by(patient_id: patient_id,
                              site_id: site_id)&.hashed_value || patient_id
    end
  end
end
