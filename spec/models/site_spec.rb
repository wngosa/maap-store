require 'rails_helper'

RSpec.describe Site, type: :model do
  subject { build :site }

  it { is_expected.to be_valid }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:address) }
  it { is_expected.to validate_presence_of(:location) }
end
