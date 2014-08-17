require 'spec_helper'

describe Group::Commands::Group::Create do
  # it_acts_as_single_create_command(:groups, :group)

  is_required :application_id, :created_by, :name
  is_optional :account_id, :description, :invitation_required
end
