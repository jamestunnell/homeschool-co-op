class AddWorkshopToSession < ActiveRecord::Migration
  def change
    add_column :sessions, :workshop, :boolean
  end
end
