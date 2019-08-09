require 'rails_helper'

RSpec.describe ClinicalService, type: :model do
  subject { build :clinical_service }

  it { is_expected.to validate_presence_of(:name) }

  it { is_expected.to be_valid }
end
