FactoryGirl.define do
  factory :group, :class => RestPack::Group::Service::Models::Group do
    sequence(:name)         {|n| "Group ##{n}" }
    sequence(:description)  {|n| "Description ##{n}" }
    sequence(:application_id)
    sequence(:created_by)
    invitation_required     true
  end
end
