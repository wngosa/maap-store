require 'rails_helper'

RSpec.describe CultureType, type: :model do
  subject { build :culture_type }

  it { is_expected.to validate_presence_of(:name) }

  it { is_expected.to be_valid }
end
