require 'spec_helper'

describe Models::Invitation do
  it { should validate_presence_of(:application_id) }
  it { should validate_presence_of(:group_id) }
  it { should validate_presence_of(:inviter_id) }
  it { should validate_presence_of(:inviter_name) }
  it { should validate_presence_of(:status_id) }

  it { should ensure_length_of(:email).is_at_most(512) }
  it { should ensure_length_of(:inviter_name).is_at_most(128) }
  it { should ensure_length_of(:access_key).is_at_most(128) }

  it { should_not allow_mass_assignment_of(:access_key) }

  it { should belong_to(:group) }
  it { should have_many(:memberships) }

  Membership = Models::Membership
  Invitation = Models::Invitation

  context "when accepting" do
    context "a valid single-use user invitation" do
      before do
        @invitation = create(:invitation, invitee_id: 142857)

        Membership.count.should == 1
        @membership = Invitation.accept(@invitation.application_id, @invitation.invitee_id, @invitation.access_key)
        Membership.count.should == 2
      end

      it "creates a new member for the group" do
        @membership.user_id.should == 142857
        @membership.application_id.should == @invitation.application_id
        @membership.group_id.should == @invitation.group_id
        @membership.invitation_id.should == @invitation.id
      end

      it "marks the invitation as accepted" do
        @invitation.reload.status.should == :accepted
      end

      it "can only be used once" do
        expect do
          Invitation.accept(@invitation.application_id, @invitation.invitee_id, @invitation.access_key)
        end.to raise_error('Invalid invitation')
      end

      it "can only be used by the invitee" do
        @invitation = create(:invitation, invitee_id: 142857)
        expect do
          @membership = Invitation.accept(@invitation.application_id, 999, @invitation.access_key)
        end.to raise_error('Invalid invitee')
      end
    end

     context "a valid multi-use invitation" do
      before do
        @invitation = create(:invitation, remaining_uses: 3)
        Membership.count.should == 1
      end

      it "can be accepted by a user" do
        @membership = Invitation.accept(@invitation.application_id, 1234, @invitation.access_key)
        Membership.count.should == 2
        @membership.user_id.should == 1234
      end

      it "should decrement the remaining_uses by 1" do
        @invitation.remaining_uses.should == 3
        Invitation.accept(@invitation.application_id, 1234, @invitation.access_key)
        @invitation.reload.remaining_uses.should == 2
      end
    end

    context "a multi-use invitation with no remaining uses" do
      before do
        @invitation = create(:invitation, remaining_uses: 0)
      end

      it "can't be used" do
        expect do
          Invitation.accept(@invitation.application_id, 1234, @invitation.access_key)
        end.to raise_error('Invitation has expired')
      end
    end

    context "an expired invitation" do
      before do
        @invitation = create(:invitation, invitee_id: 142857, expires_at: 1.second.ago)
      end

      it "can't be used" do
        expect do
          Invitation.accept(@invitation.application_id, 142857, @invitation.access_key)
        end.to raise_error('Invitation has expired')
      end
    end
  end

  context "access_key" do
    it "defaults to a length of 16" do
      invitation = create(:invitation)
      invitation.access_key.length.should == 16
    end
    it "allows the access_key length to be set" do
      invitation = create(:invitation, access_key_length: 5)
      invitation.access_key.length.should == 5
    end
  end

  context "status" do
    it "defaults to :available" do
      invitation = create(:invitation)
      invitation.status.should == :available
    end

    [:pending, :available, :accepted, :cancelled, :expired].each do |status|
      it "can be :#{status}" do
        invitation = create(:invitation, status: status)
        invitation.status.should == status
      end
    end
  end
end
