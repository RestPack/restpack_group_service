require 'spec_helper'

describe Group::Commands::Invitation::Rsvp do
  let(:response) { subject.class.run(params) }
  let(:params) { {} }

  before do
    @invitation = create(:invitation, email: 'gavin@restpack.org')
  end

  context 'when accepting' do
    context 'with valid params' do
      let(:params) { {
        application_id: @invitation.application_id,
        access_key: @invitation.access_key,
        user_id: 142857
      } }

      it 'adds the user to the group' do
        response.success?.should == true
        it_has_membership true, @invitation.group, 142857
      end

      it 'updates the invite status' do
        response.success?.should == true
        @invitation.reload.status.should == :accepted
      end
    end

    context 'with invalid key' do
      let(:params) { {
        application_id: @invitation.application_id,
        access_key: @invitation.access_key + 'invalid',
        user_id: 142857
      } }

      it 'fails' do
        response.success?.should == false
        response.status.should == :not_found
        it_has_membership false, @invitation.group, 142857
      end
    end
  end

  context 'when rejecting' do
    let(:params) { {
      application_id: @invitation.application_id,
      access_key: @invitation.access_key,
      user_id: 142857,
      accept: false
    } }

    it 'doesnt add the user to the group' do
      response.success?.should == true
      it_has_membership false, @invitation.group, 142857
    end

    it 'updates the invite status' do
      response.success?.should == true
      @invitation.reload.status.should == :rejected
    end
  end

  def it_has_membership(expected, group, user_id)
    is_member = group.memberships.any? { |member| member.user_id == user_id }

    if expected
      is_member.should be(true), "User #{user_id} should belong to Group #{group.id}"
    else
      is_member.should be(false), "User #{user_id} should not belong to Group #{group.id}"
    end
  end
end
