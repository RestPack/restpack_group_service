FactoryGirl.define do
  factory :api_group, class: Hash do
    sequence(:name)         {|n| "Group ##{n}" }
    sequence(:description)  {|n| "Description ##{n}" }
    sequence(:application_id)
    sequence(:created_by)
    invitation_required     true

    initialize_with { attributes }
  end
end
