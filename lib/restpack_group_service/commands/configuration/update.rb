module Group::Commands::Configuration
  class Update < RestPack::Service::Commands::Update
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

    private

    private

    def update_model(model, model_inputs)
      model.data = {
        rsvp_url: model_inputs[:rsvp_url]
      }
      model.save!
      model
    end
  end
end
