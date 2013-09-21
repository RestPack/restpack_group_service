require_relative '../../spec_helper'

describe Commands::Membership::List do
  is_required :application_id
  is_optional :account_id, :group_id, :user_id, :is_account_group, :page, :page_size

  pending
end
