class CreateStations < ActiveRecord::Migration[6.0]
  def change
    create_table :stations do |t|
      t.string :name
      t.string :status
      t.references :location, null: true, foreign_key: true
      t.references :warehouse, null: true, foreign_key: true

      t.timestamps
    end
  end
end