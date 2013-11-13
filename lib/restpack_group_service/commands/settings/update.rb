module Commands::Groups::Settings
  class Update < RestPack::Service::Command
    required do
      array :settings do
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
        settings: []
      }

      Models::Groups::Settings.transaction do
        inputs[:settings].each do |setting|
          model = Models::Groups::Settings.find setting[:id]
          model.data = {
            rsvp_url: setting[:rsvp_url]
          }
          model.save!
          result[:settings] << Serializers::Groups::Settings.as_json(model)
        end
      end

      return result
    end
  end
end
