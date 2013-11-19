module Commands::Groups::Invitation
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
      invitations = Models::Groups::Invitation.create!(inputs[:invitations])
      send_email(invitations)
      Serializers::Groups::Invitation.serialize(invitations)
    end

    private

    def send_email(invitations)
      invitations.each do |invitation|
        if invitation.email
          rsvp_url = invitation.configuration.data['rsvp_url']

          Messaging::Email::Send.run!({
            application_id: invitation.application_id,
            template: 'group.invitation',
            to: invitation.email,
            data: {
              inviter_name: invitation.inviter_name,
              access_key: invitation.access_key,
              group_name: invitation.group.name,
              accept_url: "#{rsvp_url}?access_key=#{invitation.access_key}",
              reject_url: "#{rsvp_url}?access_key=#{invitation.access_key}&accept=false"
            }
          })
        end
      end
    end
  end
end
