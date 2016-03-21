class CreateSpots < ActiveRecord::Migration
  def change
    create_table :spots do |t|
      t.string :nom
      t.string :adresse

      t.timestamps null: false
    end
  end
end
