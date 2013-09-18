require 'spec_helper'

describe RestPack::Group::Service::Models::Group do
  it { should validate_presence_of(:application_id) }
  it { should validate_presence_of(:created_by) }
  it { should validate_presence_of(:name) }

  it { should ensure_length_of(:name).is_at_most(256) }
  it { should ensure_length_of(:description).is_at_most(1024) }

  it { should have_many(:memberships) }
  it { should have_many(:invitations) }
end

