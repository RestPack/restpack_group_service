module Commands::Groups::Group
  class Create < RestPack::Service::Commands::Create
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
  end
end
