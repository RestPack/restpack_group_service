module Commands::Groups::Configuration
  class Update < RestPack::Service::Command
    required do
      array :configurations do
        hash do
          required do
            integer :id
            string :rsvp_url
          end
        end
      end
    end

    def execute
      result = {
        configurations: []
      }

      Models::Groups::Configuration.transaction do
        inputs[:configurations].each do |configuration|
          model = Models::Groups::Configuration.find configuration[:id]
          model.data = {
            rsvp_url: configuration[:rsvp_url]
          }
          model.save!
          result[:configurations] << Serializers::Groups::Configuration.as_json(model)
        end
      end

      return result
    end
  end
end
