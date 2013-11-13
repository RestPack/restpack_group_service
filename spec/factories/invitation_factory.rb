FactoryGirl.define do
  factory :invitation, :class => Models::Groups::Invitation do
    sequence(:application_id)
    sequence(:inviter_id)
    sequence(:inviter_name) {|n| "Inviter ##{n}" }
    group
  end
end
