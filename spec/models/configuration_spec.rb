require 'spec_helper'

describe Group::Models::Configuration do
  it { should validate_presence_of(:application_id) }
end
