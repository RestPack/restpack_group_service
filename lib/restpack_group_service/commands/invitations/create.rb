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
              string :inviter_name
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
          #TODO: GJ: add this to group service configuration
          group_rsvp_url = "http://auth.thingroulette.io:8002/groups/rsvp"

          Commands::Email::Send.run!({
            application_id: invitation.application_id,
            template: 'group.invitation',
            to: invitation.email,
            data: {
              inviter_name: invitation.inviter_name,
              access_key: invitation.access_key,
              group_name: invitation.group.name,
              accept_url: "#{group_rsvp_url}?access_key=#{invitation.access_key}",
              reject_url: "#{group_rsvp_url}?access_key=#{invitation.access_key}&accept=false"
            }
          })
        end
      end
    end
   end
  end
end
