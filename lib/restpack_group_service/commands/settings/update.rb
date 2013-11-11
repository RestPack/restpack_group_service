module RestPack::Group::Service::Commands
  module Settings
    class Update < RestPack::Service::Command
      required do
        array :settings do
          hash do
            required do
              integer :application_id
              hash :data do
                string :rsvp_url
              end
            end
          end
        end
      end

      def execute
        result = {
          settings: []
        }

        Models::Settings.transaction do
          inputs[:settings].each do |setting|
            model = Models::Settings.find_or_create_by({
              application_id: setting[:application_id]
            })

            model.data = setting[:data]
            model.save!

            result[:settings] << Serializers::Settings.as_json(model)
          end
        end

        return result
      end
    end
  end
end
