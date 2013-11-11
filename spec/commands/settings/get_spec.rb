require 'spec_helper'

describe Commands::Settings::Get do
  is_required :application_id

  let(:response) { subject.class.run(params) }
  let(:params) { {} }

  context 'when no record exists' do
    let(:params) { {
      application_id: 123
    } }

    it 'return new settings' do
      response.success?.should == true
      response.result[:settings].length.should == 1
      response.result[:settings].first[:id].should_not == ''
      response.result[:settings].first[:application_id].should == 123
      response.result[:settings].first[:data].should == {}
    end
  end

  context 'when a record exists' do
    before do
      @setting = Models::Settings.create({
        application_id: 123,
        data: { 'rsvp_url' => 'http://somewhere.org/rsvp' }
      })
    end

    let(:params) { {
      application_id: @setting.application_id
    } }

    it 'returns the settings' do
      response.success?.should == true
      response.result[:settings].length.should == 1
      response.result[:settings].first[:id].should == @setting.id.to_s
      response.result[:settings].first[:data].should == {
        'rsvp_url' => 'http://somewhere.org/rsvp'
      }
    end
  end
end