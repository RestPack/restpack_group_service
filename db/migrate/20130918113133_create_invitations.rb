class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :restpack_invitations do |t|
      t.integer   :application_id,        :null => false
      t.integer   :group_id,              :null => false
      t.integer   :inviter_id,            :null => false
      t.integer   :invitee_id
      t.integer   :status_id,             :null => false
      t.string    :email,                                 :limit => 512
      t.string    :access_key,                            :limit => 128
      t.datetime  :expires_at
      t.integer   :remaining_uses

      t.timestamps
    end
  end
end
