require 'spec_helper'

describe Commands::Settings::Update do
  let(:response) { subject.class.run(params) }

  before do
    @setting = Models::Settings.create({
      application_id: 123,
      data: { 'rsvp_url' => 'http://somewhere.org/rsvp' }
    })
  end

  let(:params) { {
    settings: [{
      application_id: 123,
      data: { 'rsvp_url' => 'http://new.io/rsvp' }
    }]
  } }

  it 'updates the setting' do
    response.success?.should == true
    response.result[:settings].length.should == 1

    @setting.reload
    @setting.data['rsvp_url'].should == 'http://new.io/rsvp'
    response.result[:settings].first == Serializers::Settings.as_json(@setting)
  end
end
