module Commands::Groups::Group
  class Create < RestPack::Service::Command
    required do
      array :groups do
        hash do
          required do
            integer :application_id
            integer :created_by
            string :name
          end

          optional do
            integer :account_id
            string :description
            boolean :invitation_required
          end
        end
      end
    end

    def execute
      groups = Models::Groups::Group.create!(inputs[:groups])
      Serializers::Groups::Group.serialize(groups)
    end
  end
end
