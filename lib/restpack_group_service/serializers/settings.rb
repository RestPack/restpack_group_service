module RestPack::Group::Service::Serializers
  class Settings
    include RestPack::Serializer

    self.model_class = Models::Settings
    self.key = :settings

    attributes :id, :application_id, :rsvp_url

    def rsvp_url
      @model.data['rsvp_url']
    end
  end
end
