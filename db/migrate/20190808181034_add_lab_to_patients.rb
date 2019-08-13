class AddLabToPatients < ActiveRecord::Migration[5.2]
  def change
    add_reference :patients, :site, foreign_key: true
  end
end
