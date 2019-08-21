class AntibioticConsumptionStat < ApplicationRecord
  belongs_to :antibiotic, optional: false

  belongs_to :site
end
