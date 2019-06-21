require 'rails_helper'

RSpec.describe Lab, type: :model do
  subject { build :lab }

  it { is_expected.to be_valid }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:address) }
  it { is_expected.to validate_presence_of(:location) }
end
