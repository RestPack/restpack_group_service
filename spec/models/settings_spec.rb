require 'spec_helper'

describe Models::Settings do
  it { should validate_presence_of(:application_id) }
end
