module RestPack::Group::Service::Commands
  module Invitation
    class Create < RestPack::Service::Command
      required do
        array :invitations do
          hash do
            required do
              integer :application_id
              integer :group_id
              integer :inviter_id
            end

            optional do
              string :email
            end
          end
        end
      end

      def execute
        invitations = Models::Invitation.create!(inputs[:invitations])

        if inputs[:email]
          #TODO: GJ: send emails
        end

        Serializers::Invitation.serialize(invitations)
      end
    end
  end
end
