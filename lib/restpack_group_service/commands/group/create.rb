module Commands::Groups::Group
  class Create < RestPack::Service::Commands::SingleCreate
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
