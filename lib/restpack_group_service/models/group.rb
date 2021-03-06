module Group::Models
  class Group < ActiveRecord::Base
    self.table_name = :restpack_group_groups

    attr_accessible :application_id, :account_id, :created_by, :name, :description, :invitation_required
    validates_presence_of :application_id, :created_by, :name

    validates :name, :length => { :maximum => 256 }
    validates :description, :length => { :maximum => 1024 }

    has_many :memberships
    has_many :invitations

    after_initialize :set_defaults
    after_create :create_default_member

    private

    def set_defaults
      self.invitation_required ||= false
    end

    def create_default_member
      self.memberships << Membership.new(
        user_id: self.created_by,
        application_id: self.application_id,
        account_id: self.account_id
      )
    end
  end
end
