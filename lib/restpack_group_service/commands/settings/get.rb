module RestPack::Group::Service::Commands
  module Settings
    class Get < RestPack::Service::Command
      required do
        integer :application_id
      end

      def execute
        settings = Models::Settings.find_or_create_by({
          application_id: inputs[:application_id]
        })

        Serializers::Settings.serialize(settings)
      end
    end
  end
end
