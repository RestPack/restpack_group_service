module RestPack::Group::Service::Models
  class Group < ActiveRecord::Base
    self.table_name = :restpack_groups

    attr_accessible :application_id, :account_id, :created_by, :name, :description, :invitation_required
    validates_presence_of :application_id, :created_by, :name

    validates :name, :length => { :maximum => 256 }
    validates :description, :length => { :maximum => 1024 }
  end
end
