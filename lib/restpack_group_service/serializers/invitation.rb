module RestPack::Group::Service::Serializers
  class Invitation
    include RestPack::Serializer

    self.model_class = Models::Invitation
    self.key = :invitations

    attributes :id, :application_id, :group_id, :inviter_id, :invitee_id,
               :expires_at, :remaining_uses, :href
    can_include :groups
    can_filter_by :application_id, :inviter_id, :invitee_id
  end
end
