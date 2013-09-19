module RestPack::Group::Service::Serializers
  class MembershipSerializer
    include RestPack::Serializer

    self.model_class = RestPack::Group::Service::Models::Membership
    self.key = :memberships

    attributes :id, :application_id, :account_id, :group_id, :user_id,
               :invitation_id, :href
    can_include :groups, :invitations
  end
end
