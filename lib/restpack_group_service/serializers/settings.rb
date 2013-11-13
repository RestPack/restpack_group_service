module Serializers::Groups
  class Settings
    include RestPack::Serializer

    self.model_class = Models::Groups::Settings
    self.key = :settings

    attributes :id, :application_id, :rsvp_url

    def rsvp_url
      @model.data['rsvp_url']
    end
  end
end
