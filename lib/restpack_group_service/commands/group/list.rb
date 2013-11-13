module Commands::Groups::Group
  class List < RestPack::Service::Command
    required do
      integer :application_id
    end

    optional do
      integer :account_id
      integer :created_by
      boolean :is_account_group, default: false
      string :include
      integer :page
      integer :page_size
    end

    def execute
      scope = Models::Groups::Group.all

      if is_account_group
        scope = scope.where("account_id IS NOT NULL")
      else
        scope = scope.where("account_id IS NULL") unless account_id
      end

      Serializers::Groups::Group.resource(inputs, scope)
    end
  end
end
