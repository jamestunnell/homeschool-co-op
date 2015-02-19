class AddAgreementToUser < ActiveRecord::Migration
  def change
    add_column :users, :parent_agreement, :boolean
  end
end
