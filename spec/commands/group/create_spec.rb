require_relative '../../spec_helper'

describe RestPack::Group::Service::Commands::Group::Create do
  #TODO: GJ: validate array
  # is_required :application_id, :created_by, :name
  # is_optional :account_id, :description, :invitation_required

  context 'creating an group' do
    let(:response) { subject.class.run(params) }

    context 'with valid params' do
      let(:group) { {
        application_id: 123,
        created_by: 234,
        name: "My New Group"
      } }
      let(:params) { {
        groups: [group]
      } }

      it 'returns the newly created activity' do
        response.success?.should == true

        groups = response.result[:groups]
        groups.length.should == 1

        groups.first[:application_id].should == 123
        groups.first[:created_by].should == 234
        groups.first[:name].should == "My New Group"
      end
    end
  end
end
