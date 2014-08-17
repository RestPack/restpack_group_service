module Group::Models
  class Membership < ActiveRecord::Base
    self.table_name = :restpack_group_memberships

    attr_accessible :application_id, :account_id, :group_id, :invitation_id, :user_id
    validates_presence_of :application_id, :group_id, :user_id

    belongs_to :group
    belongs_to :invitation
  end
end
