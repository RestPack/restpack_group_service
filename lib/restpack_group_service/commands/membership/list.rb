module RestPack::Group::Service::Commands
  module Membership
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
      end

      def execute
        # TODO: GJ: remove the scope when we can specify custom serializer filters
        #           https://github.com/RestPack/restpack_serializer/issues/42
        scope = RestPack::Group::Service::Models::Membership.all
        scope = scope.where(application_id: application_id)
        scope = scope.where(account_id: account_id) if account_id
        scope = scope.where(group_id: group_id) if group_id
        scope = scope.where(user_id: user_id) if user_id

        if is_account_group
          scope = scope.where("account_id IS NOT NULL")
        else
          scope = scope.where("account_id IS NULL") unless account_id
        end

        RestPack::Group::Service::Serializers::MembershipSerializer.resource(
          inputs, scope
        )
      end
    end
  end
end
