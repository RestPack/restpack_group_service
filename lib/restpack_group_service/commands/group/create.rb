module RestPack::Group::Service::Commands
  module Group
    class Create < RestPack::Service::Command
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

      def execute
        groups = RestPack::Group::Service::Models::Group.create!(inputs[:groups])
        RestPack::Group::Service::Serializers::GroupSerializer.serialize(groups)
      end
    end
  end
end
