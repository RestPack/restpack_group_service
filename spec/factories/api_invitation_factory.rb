FactoryGirl.define do
  factory :api_invitation, class: Hash do
    sequence(:application_id)
    sequence(:group_id)
    sequence(:inviter_id)
    sequence(:inviter_name) {|n| "Inviter ##{n}" }

    initialize_with { attributes }
  end
end
