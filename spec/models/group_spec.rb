require 'spec_helper'

describe Group::Models::Group do
  it { should validate_presence_of(:application_id) }
  it { should validate_presence_of(:created_by) }
  it { should validate_presence_of(:name) }

  it { should ensure_length_of(:name).is_at_most(256) }
  it { should ensure_length_of(:description).is_at_most(1024) }

  it { should have_many(:memberships) }
  it { should have_many(:invitations) }

  context "when creating" do
    context "a valid group" do
      before do
        @group = create(:group, account_id: 999)
      end

      it "should create a default member" do
        @group.memberships.count.should == 1
        @group.memberships.first.user_id.should == @group.created_by
        @group.memberships.first.account_id.should == @group.account_id
      end
    end
  end
end
