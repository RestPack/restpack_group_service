FactoryGirl.define do
  factory :group, :class => RestPack::Group::Service::Models::Group do
    sequence(:name)         {|n| "Group ##{n}" }
    sequence(:description)  {|n| "Description ##{n}" }
    application_id          142857
    created_by              285742
    invitation_required     true
  end
end
