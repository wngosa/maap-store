require 'rails_helper'

RSpec.describe SpecimenSource, type: :model do
  subject { build :specimen_source }

  it { is_expected.to validate_presence_of(:name) }

  it { is_expected.to be_valid }
end
