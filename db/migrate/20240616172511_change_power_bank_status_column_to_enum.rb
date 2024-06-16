class ChangePowerBankStatusColumnToEnum < ActiveRecord::Migration[7.1]
  def change
    change_column :power_banks, :status, :integer, default: 0
  end
end
