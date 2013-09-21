module RestPack::Group::Service::Serializers
  class Membership
    include RestPack::Serializer

    self.model_class = Models::Membership
    self.key = :memberships

    attributes :id, :application_id, :account_id, :group_id, :user_id,
               :invitation_id, :href
    can_include :groups, :invitations
  end
end
