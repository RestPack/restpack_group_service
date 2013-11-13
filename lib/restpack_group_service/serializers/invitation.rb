module Serializers::Groups
  class Invitation
    include RestPack::Serializer

    self.model_class = Models::Groups::Invitation
    self.key = :invitations

    attributes :id, :application_id, :group_id, :inviter_id, :invitee_id,
               :expires_at, :remaining_uses, :href
    can_include :groups
    can_filter_by :application_id, :inviter_id, :invitee_id
  end
end
