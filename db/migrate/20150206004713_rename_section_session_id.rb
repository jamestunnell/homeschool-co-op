class RenameSectionSessionId < ActiveRecord::Migration
  def change
    rename_column :sections, :session_id, :term_id
  end
end
