module Commands::Groups::Settings
  class Get < RestPack::Service::Command
    required do
      integer :application_id
    end

    def execute
      settings = Models::Groups::Settings.find_or_create_by({
        application_id: inputs[:application_id]
      })

      Serializers::Groups::Settings.serialize(settings)
    end
  end
end
