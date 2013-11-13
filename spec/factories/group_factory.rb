FactoryGirl.define do
  factory :group, :class => Models::Groups::Group do
    sequence(:name)         {|n| "Group ##{n}" }
    sequence(:description)  {|n| "Description ##{n}" }
    sequence(:application_id)
    sequence(:created_by)
    invitation_required     true
  end
end
