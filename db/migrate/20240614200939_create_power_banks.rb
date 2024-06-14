class CreatePowerBanks < ActiveRecord::Migration[7.1]
  def change
    create_table :power_banks do |t|
      t.string :serial_number
      t.string :status
      t.references :station, null: false, foreign_key: true
      t.references :warehouse, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
