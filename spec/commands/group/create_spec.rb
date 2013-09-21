require_relative '../../spec_helper'

describe Commands::Group::Create do
  #TODO: GJ: validate array
  # is_required :application_id, :created_by, :name
  # is_optional :account_id, :description, :invitation_required

  context 'creating a group' do
    let(:response) { subject.class.run(params) }

    context 'with valid params' do
      let(:group) { {
        application_id: 123,
        created_by: 234,
        name: 'My New Group',
        account_id: 345,
        description: 'this is the description',
        invitation_required: true
      } }
      let(:params) { {
        groups: [group]
      } }

      it 'returns the newly created group' do
        response.success?.should == true

        groups = response.result[:groups]
        groups.length.should == 1

        groups.first[:application_id].should == 123
        groups.first[:created_by].should == 234
        groups.first[:name].should == "My New Group"
        groups.first[:account_id].should == 345
        groups.first[:description].should == 'this is the description'
        groups.first[:invitation_required].should == true
      end
    end
  end
end
