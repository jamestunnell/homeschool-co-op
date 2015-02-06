class RenameAdultIdToUserId < ActiveRecord::Migration
  def change
    rename_column :children, :adult_id, :user_id
    rename_column :sections, :adult_id, :user_id
  end
end
