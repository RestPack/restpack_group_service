module RestPack::Group::Service::Commands
  module Group
    class List < RestPack::Service::Command
      required do
        integer :application_id
      end

      optional do
        integer :account_id
        integer :created_by
        boolean :is_account_group, default: false
        integer :page
        integer :page_size
      end

      def execute
        # TODO: GJ: remove the scope when we can specify custom serializer filters
        #           https://github.com/RestPack/restpack_serializer/issues/42
        scope = Models::Group.all
        scope = scope.where(application_id: application_id)
        scope = scope.where(account_id: account_id) if account_id
        scope = scope.where(created_by: created_by) if created_by

        if is_account_group
          scope = scope.where("account_id IS NOT NULL")
        else
          scope = scope.where("account_id IS NULL") unless account_id
        end

        Serializers::Group.resource(inputs, scope)
      end
    end
  end
end
