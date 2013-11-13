module Commands::Groups::Membership
  class List < RestPack::Service::Command
    required do
      integer :application_id
    end

    optional do
      integer :account_id
      integer :group_id
      integer :user_id
      boolean :is_account_group, default: false
      integer :page
      integer :page_size
      string :include
    end

    def execute
      scope = Models::Membership.all
      if is_account_group
        scope = scope.where("account_id IS NOT NULL")
      else
        scope = scope.where("account_id IS NULL") unless account_id
      end

      Serializers::Membership.resource(inputs, scope)
    end
  end
end
