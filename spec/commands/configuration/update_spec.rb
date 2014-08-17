require 'spec_helper'

describe Group::Commands::Configuration::Update do
  let(:response) { subject.class.run(params) }

  before do
    @configuration = Group::Models::Configuration.create({
      application_id: 123,
      data: { 'rsvp_url' => 'http://somewhere.org/rsvp' }
    })
  end

  let(:params) { {
    configurations: [{
      id: @configuration.id,
      rsvp_url: 'http://new.io/rsvp'
    }]
  } }

  it 'updates the configuration' do
    response.success?.should == true
    response.result[:configurations].length.should == 1

    @configuration.reload
    @configuration.data['rsvp_url'].should == 'http://new.io/rsvp'
    response.result[:configurations].first == Group::Serializers::Configuration.as_json(@configuration)
  end
end
