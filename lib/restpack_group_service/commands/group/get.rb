module RestPack::Group::Service::Commands
  module Group
    class Get < RestPack::Service::Command
      required do
        integer :id
        integer :application_id
      end

      def execute
        result = Serializers::Group.resource(inputs)

        if result[:groups].empty?
          status :not_found
        else
          result
        end
      end
    end
  end
end
