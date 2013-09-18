FactoryGirl.define do
  factory :invitation, :class => RestPack::Group::Service::Models::Invitation do
    application_id 999142857
    inviter_id     999285742
    group
  end
end
