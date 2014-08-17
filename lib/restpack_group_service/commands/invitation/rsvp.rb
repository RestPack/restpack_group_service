module Group::Commands::Invitation
  class Rsvp < RestPack::Service::Command
    required do
      integer :application_id
      integer :user_id
      string :access_key
      boolean :accept, default: true
    end

    def execute
      invitation = Model.find_by({
        application_id: inputs[:application_id],
        access_key: inputs[:access_key]
      })

      if invitation
        if inputs[:accept]
          membership = invitation.accept(inputs[:user_id])
        else
          invitation.reject(inputs[:user_id])
        end

        Serializer.serialize(invitation)
      else
        status :not_found unless invitation
      end
    end
  end
end
