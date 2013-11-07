module RestPack::Group::Service::Commands
  module Invitation
    class Rsvp < RestPack::Service::Command
      required do
        integer :application_id
        integer :user_id
        string :access_key
        boolean :accept, default: true
      end

      def execute
        invitation = Models::Invitation.find_by({
          application_id: inputs[:application_id],
          access_key: inputs[:access_key]
        })

        if invitation
          if inputs[:accept]
            membership = invitation.accept(inputs[:user_id])
          else
            invitation.reject(inputs[:user_id])
          end

          Serializers::Invitation.serialize(invitation)
        else
          status :not_found unless invitation
        end
      end
    end
  end
end
