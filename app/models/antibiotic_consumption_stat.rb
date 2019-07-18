class AntibioticConsumptionStat < ApplicationRecord
  belongs_to :antibiotic, optional: false
end
