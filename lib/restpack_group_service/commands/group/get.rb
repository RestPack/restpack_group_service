module RestPack::Group::Service::Commands
  module Group
    class Get < RestPack::Service::Command
      required do
        integer :id
        integer :application_id
      end

      def execute
        # TODO: GJ: remove the :application_id scope when we can specify custom serializer filters
        #          https://github.com/RestPack/restpack_serializer/issues/42
        result = Serializers::Group.resource(
          inputs,
          Models::Group.where(application_id: inputs[:application_id])
        )

        if result[:groups].empty?
          status :not_found
        else
          result
        end
      end
    end
  end
end
