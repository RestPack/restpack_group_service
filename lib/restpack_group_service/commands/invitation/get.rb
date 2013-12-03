module Commands::Groups::Invitation
  class Get < RestPack::Service::Command
    required do
      string :id
      integer :application_id
    end

    def execute
      result = Serializers::Groups::Invitation.resource(inputs)

      if result[:invitations].empty?
        status :not_found
      else
        result
      end
    end
  end
end
