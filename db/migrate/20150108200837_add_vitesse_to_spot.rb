class AddVitesseToSpot < ActiveRecord::Migration
  def change
    add_column :spots, :vitesse, :float
  end
end
