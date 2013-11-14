module Commands::Groups::Configuration
  class Get < RestPack::Service::Command
    required do
      integer :application_id
    end

    def execute
      models = Models::Groups::Configuration.find_or_create_by({
        application_id: inputs[:application_id]
      })

      Serializers::Groups::Configuration.serialize(models)
    end
  end
end
