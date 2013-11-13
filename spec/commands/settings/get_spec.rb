require 'spec_helper'

describe Commands::Groups::Settings::Get do
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
      response.result[:settings].first[:rsvp_url].should == nil
    end
  end

  context 'when a record exists' do
    before do
      @setting = Models::Groups::Settings.create({
        application_id: 123,
        data: { 'rsvp_url' => 'http://somewhere.org/rsvp' }
      })
    end

    let(:params) { {
      application_id: @setting.application_id
    } }

    it 'returns the settings' do
      response.success?.should == true
      settings = response.result[:settings]
      settings.length.should == 1
      settings.first[:id].should == @setting.id.to_s
      settings.first[:rsvp_url].should == 'http://somewhere.org/rsvp'
    end
  end
end
