module RestPack::Group::Service::Serializers
  class Settings
    include RestPack::Serializer

    self.model_class = Models::Settings
    self.key = :settings

    attributes :id, :application_id, :data
  end
end
