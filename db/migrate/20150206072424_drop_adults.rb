class DropAdults < ActiveRecord::Migration
  def change
    drop_table :adults
  end
end
