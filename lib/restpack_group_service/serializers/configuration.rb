module Group::Serializers
  class Configuration
    include RestPack::Serializer

    self.model_class = ::Group::Models::Configuration
    self.key = :configurations

    attributes :id, :application_id, :rsvp_url

    def rsvp_url
      @model.data['rsvp_url']
    end
  end
end
