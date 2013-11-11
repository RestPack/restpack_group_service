class CreateGroupSettings < ActiveRecord::Migration
  def change
    create_table :restpack_group_settings do |t|
      t.integer :application_id,    :null => false
      t.integer :domain_id
      t.json    :data
      t.timestamps
    end
  end
end
