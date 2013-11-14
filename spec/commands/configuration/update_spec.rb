require 'spec_helper'

describe Commands::Groups::Configuration::Update do
  let(:response) { subject.class.run(params) }

  before do
    @configuration = Models::Groups::Configuration.create({
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
    response.result[:configurations].first == Serializers::Groups::Configuration.as_json(@configuration)
  end
end
