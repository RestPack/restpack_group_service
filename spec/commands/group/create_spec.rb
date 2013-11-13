require 'spec_helper'

describe Commands::Groups::Group::Create do
  it_acts_as_create_command(:groups, :group)

  pending 'validate command inputs'
end
