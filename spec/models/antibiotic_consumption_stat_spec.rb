require 'rails_helper'

RSpec.describe AntibioticConsumptionStat, type: :model do
  subject { build :antibiotic_consumption_stat }

  it { is_expected.to be_valid }

  it { is_expected.to belong_to(:antibiotic).required }
end
