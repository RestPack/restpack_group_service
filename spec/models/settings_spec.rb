require 'spec_helper'

describe Models::Groups::Settings do
  it { should validate_presence_of(:application_id) }
end
