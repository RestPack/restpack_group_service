module Commands::Groups::Membership
  class Get < RestPack::Service::Command
    required do
      string :id
      integer :application_id
    end

    def execute
      result = Serializers::Groups::Membership.resource(inputs)

      if result[:memberships].empty?
        status :not_found
      else
        result
      end
    end
  end
end
