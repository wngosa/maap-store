require 'rails_helper'

 RSpec.describe PatientLocation, type: :model do
  subject { build :patient_location }

   it { is_expected.to validate_presence_of(:name) }

   it { is_expected.to be_valid }
end
