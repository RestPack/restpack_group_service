FactoryGirl.define do
  factory :invitation, :class => RestPack::Group::Service::Models::Invitation do
    application_id          142857
    inviter_id              285742
    group
  end
end
