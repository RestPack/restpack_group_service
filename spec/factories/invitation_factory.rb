FactoryGirl.define do
  factory :invitation, :class => RestPack::Group::Service::Models::Invitation do
    sequence(:application_id)
    sequence(:inviter_id)
    group
  end
end
