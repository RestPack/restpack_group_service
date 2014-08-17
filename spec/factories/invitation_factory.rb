FactoryGirl.define do
  factory :invitation, :class => Group::Models::Invitation do
    sequence(:application_id)
    sequence(:inviter_id)
    sequence(:inviter_name) {|n| "Inviter ##{n}" }
    group
  end
end
