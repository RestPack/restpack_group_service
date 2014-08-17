module Group::Commands::Group
  class List < RestPack::Service::Commands::List
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
