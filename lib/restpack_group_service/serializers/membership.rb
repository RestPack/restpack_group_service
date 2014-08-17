module Group::Serializers
  class Membership
    include RestPack::Serializer

    self.model_class = ::Group::Models::Membership
    self.key = :memberships

    attributes :id, :application_id, :account_id, :group_id, :user_id,
               :invitation_id, :href
    can_include :groups, :invitations
    can_filter_by :application_id, :account_id, :group_id, :user_id
  end
end
