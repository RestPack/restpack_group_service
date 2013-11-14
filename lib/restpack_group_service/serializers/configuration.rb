module Serializers::Groups
  class Configuration
    include RestPack::Serializer

    self.model_class = Models::Groups::Configuration
    self.key = :configurations

    attributes :id, :application_id, :rsvp_url

    def rsvp_url
      @model.data['rsvp_url']
    end
  end
end
