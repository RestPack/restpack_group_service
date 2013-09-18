require 'spec_helper'

describe RestPack::Group::Service::Models::Invitation do
  it { should validate_presence_of(:application_id) }
  it { should validate_presence_of(:group_id) }
  it { should validate_presence_of(:inviter_id) }
  it { should validate_presence_of(:status_id) }

  it { should ensure_length_of(:email).is_at_most(512) }
  it { should ensure_length_of(:access_key).is_at_most(128) }

  it { should_not allow_mass_assignment_of(:access_key) }

  it { should belong_to(:group) }
  it { should have_many(:memberships) }
end

