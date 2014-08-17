module Group::Commands::Membership
  class List < RestPack::Service::Commands::List
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

    private

    def scope
      scope = Model.all

      if is_account_group
        scope = scope.where("account_id IS NOT NULL")
      else
        scope = scope.where("account_id IS NULL") unless account_id
      end

      scope
    end
  end
end
