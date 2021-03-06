class CreateGroups < ActiveRecord::Migration
  def change
    create_table :restpack_group_groups do |t|
      t.integer :application_id,        :null => false
      t.integer :account_id
      t.integer :created_by,            :null => false
      t.string  :name,                  :null => false, :limit => 256
      t.string  :description,                           :limit => 1024
      t.boolean :invitation_required,   :null => false

      t.timestamps
    end
  end
end
