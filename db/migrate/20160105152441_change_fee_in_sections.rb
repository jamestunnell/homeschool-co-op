class ChangeFeeInSections < ActiveRecord::Migration
  def change
    change_column :sections, :fee, :decimal, precision: 5, scale: 2, default: 0
  end
end
