module Serializers::Groups
  class Group
    include RestPack::Serializer

    self.model_class = Models::Groups::Group
    self.key = :groups

    attributes :id, :application_id, :account_id, :created_by, :name,
               :description, :invitation_required, :href
    can_include :memberships, :invitations
    can_filter_by :application_id, :account_id, :created_by
  end
end
