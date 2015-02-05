class RemoveKindFromSession < ActiveRecord::Migration
  def change
    remove_column :sessions, :kind
  end
end
