module RestPack::Group::Service::Models
  class Invitation < ActiveRecord::Base
    self.table_name = :restpack_invitations

    STATUS = { pending: 0, available: 1, accepted: 2, cancelled: 3, expired: 4 }
    attr_accessor :access_key_length, :status
    attr_accessible :access_key_length, :channel_id, :email, :expires_at, :group_id, :invitee_id, :inviter_id, :remaining_uses, :status

    validates_presence_of :application_id, :group_id, :inviter_id, :status_id
    validates :email, :length => { maximum: 512 }
    validates :access_key, :length => { maximum: 128 }

    belongs_to :group
    has_many :memberships
  end
end
