module Commands::Groups::Group
  class Get < RestPack::Service::Command
    required do
      string :id
      integer :application_id
    end

    optional do
      string :include
    end

    def execute
      result = Serializers::Groups::Group.resource(inputs)

      if result[:groups].empty?
        status :not_found
      else
        result
      end
    end
  end
end
