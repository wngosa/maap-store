class AntibioticConsumptionStat < ApplicationRecord
  acts_as_paranoid

  belongs_to :antibiotic, optional: false

  belongs_to :site
end
