require 'spec_helper'

describe Commands::Group::Create do
  it_acts_as_create_command(:group)

  pending 'validate command inputs'
end
