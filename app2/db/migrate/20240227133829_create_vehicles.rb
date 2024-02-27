class CreateVehicles < ActiveRecord::Migration[7.0]
  def change
    create_table :vehicles do |t|
      t.string :brand
      t.string :model
      t.integer :year
      t.string :license_plate
      t.references :policy, null: false, foreign_key: true
      t.timestamps
    end
  end
end
