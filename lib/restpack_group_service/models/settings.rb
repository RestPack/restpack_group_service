module Models::Groups
  class Settings < ActiveRecord::Base
    self.table_name = :restpack_group_settings

    attr_accessible :application_id, :data
    validates_presence_of :application_id

    after_initialize -> {
      self.data ||= {}
    }
  end
end
