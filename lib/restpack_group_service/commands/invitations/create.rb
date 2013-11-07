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
        send_email(invitations)
        Serializers::Invitation.serialize(invitations)
      end

      private

    def send_email(invitations)
      invitations.each do |invitation|
        if invitation.email
          Commands::Email::Send.run!({
            application_id: invitation.application_id,
            template: 'group.invitation',
            to: invitation.email,
            data: {
              access_key: invitation.access_key,
              group_name: invitation.group.name
            }
          })
        end
      end
    end
   end
  end
end
