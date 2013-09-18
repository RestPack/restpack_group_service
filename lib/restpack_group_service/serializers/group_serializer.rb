module RestPack::Group::Service::Serializers
  class GroupSerializer
    include RestPack::Serializer

    self.model_class = RestPack::Group::Service::Models::Group
    self.key = :groups

    attributes :id, :application_id, :account_id, :created_by, :name,
               :description, :invitation_required, :href
    can_include :memberships, :invitations
  end
end
