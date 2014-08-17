require 'spec_helper'

describe Group::Models::Membership do
  it { should validate_presence_of(:application_id) }
  it { should validate_presence_of(:group_id) }
  it { should validate_presence_of(:user_id) }

  it { should belong_to(:group) }
  it { should belong_to(:invitation) }
end
