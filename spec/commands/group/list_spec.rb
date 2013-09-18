require_relative '../../spec_helper'

describe RestPack::Group::Service::Commands::Group::List do
  is_required :application_id
  is_optional :account_id, :created_by, :page, :page_size

  before do
    @groups = create_list(:group, 5)
  end

  context 'listing groups' do
    let(:response) { subject.class.run(params) }

    context ':application_id' do
      before { create_list(:group, 3, application_id: 123) }

      context 'valid' do
        let(:params) { { application_id: 123 } }
        it 'returns activities' do
          response.result[:meta][:groups][:count].should == 3
        end
      end

      context 'invalid' do
        let(:params) { { application_id: 999999 } }
        it 'returns no activities' do
          response.result[:meta][:groups][:count].should == 0
        end
      end

      pending ':application_id is required'
    end

    context ':account_id' do
      before { create_list(:group, 2, application_id: 123, account_id: 345) }

      context 'valid' do
        let(:params) { { application_id: 123, account_id: 345 } }
        it 'returns activities' do
          p response
          response.result[:meta][:groups][:count].should == 2
        end
      end

      context 'invalid' do
        let(:params) { { application_id: 123, account_id: 999999 } }
        it 'returns no activities' do
          response.result[:meta][:groups][:count].should == 0
        end
      end
    end
  end
end
