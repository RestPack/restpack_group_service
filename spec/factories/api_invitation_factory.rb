FactoryGirl.define do
  factory :api_invitation, class: Hash do
    sequence(:application_id)
    sequence(:group_id)
    sequence(:inviter_id)

    initialize_with { attributes }
  end
end
