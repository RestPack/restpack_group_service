module RestPack::Group::Service::Models
  class Invitation < ActiveRecord::Base
    self.table_name = :restpack_invitations

    STATUS = {
      pending: 0, available: 1, accepted: 2,
      rejected: 3, cancelled: 4, expired: 5
    }
    attr_accessor :access_key_length, :status
    attr_accessible :access_key_length, :application_id, :email, :expires_at,
                    :group_id, :invitee_id, :inviter_id, :inviter_name,
                    :remaining_uses, :status

    validates_presence_of :application_id, :group_id, :inviter_id, :inviter_name, :status_id
    validates :email, :length => { maximum: 512 }
    validates :inviter_name, :length => { maximum: 128 }
    validates :access_key, :length => { maximum: 128 }

    belongs_to :group
    has_many :memberships

    scope :available, -> { where(:status_id => STATUS[:available]) }

    def self.by_application_id(application_id)
      self.where 'application_id = ?', application_id
    end

    def self.by_access_key(key)
      self.where 'access_key = ?', key
    end

    after_initialize :set_defaults
    before_create :generate_access_key

    def status
      STATUS.key(read_attribute(:status_id))
    end

    def status=(status)
      write_attribute(:status_id, STATUS[status])
    end

    def self.accept(application_id, user_id, access_key) #TODO: GJ: skip if already a member
      invitation = self.available.by_application_id(application_id).by_access_key(access_key).first

      raise "Invalid invitation" unless invitation

      invitation.accept(user_id)
    end

    def accept(user_id)
      validate! user_id

      transaction do
        membership = Membership.new application_id: application_id, group_id: group_id, user_id: user_id
        self.memberships << membership
        self.use!

        membership
      end
    end

    def reject(user_id)
      validate! user_id
      self.use! false
    end

    def self.access_key_unique?(application_id, access_key)
      self.by_application_id(application_id).by_access_key(access_key).empty?
    end

    protected

    def use!(accept = true)
      if single_use?
        self.status = accept ? :accepted : :rejected
      else
        self.remaining_uses -= 1
      end
      self.save!
    end

    private

    def validate!(user_id)
      raise "Invitation is #{status}" unless status == :available
      raise "Invalid invitee" unless invitee_id.nil? || invitee_id == user_id.to_i
      raise "Invitation has expired" unless remaining_uses.nil? || remaining_uses > 0
      raise "Invitation has expired" unless expires_at.nil? || expires_at > Time.now
    end

    def single_use?
      remaining_uses.nil? || remaining_uses <= 1
    end

    def set_defaults
      self.access_key_length ||= 16
      self.status ||= :available
    end

    def generate_access_key
      length = access_key_length.to_i

      loop do
        self.access_key = SecureRandom.urlsafe_base64(length).first(length)
        break if Invitation.access_key_unique?(application_id, access_key)
      end
    end
  end
end
