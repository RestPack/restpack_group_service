class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :restpack_group_memberships do |t|
      t.integer :application_id,    :null => false
      t.integer :account_id
      t.integer :group_id,          :null => false
      t.integer :user_id,           :null => false
      t.integer :invitation_id

      t.timestamps
    end
  end
end
