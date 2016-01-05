class AddRegistrationFeeToSections < ActiveRecord::Migration
  def change
    add_column :sections, :registration_fee, :decimal, precision: 5, scale: 2, default: 10
  end
end
