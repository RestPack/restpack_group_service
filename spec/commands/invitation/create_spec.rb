require 'spec_helper'

describe Group::Commands::Invitation::Create do
  it_acts_as_create_command

  pending 'validate command inputs'
  pending 'an email should be sent if email param is present'
end
