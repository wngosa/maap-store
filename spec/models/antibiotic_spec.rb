require 'rails_helper'

RSpec.describe Antibiotic, type: :model do
  subject { build :antibiotic }

  it { is_expected.to be_valid }

  it { is_expected.to validate_presence_of(:name) }
end
