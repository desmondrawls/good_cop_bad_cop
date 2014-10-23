# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :rating do
    cop
    courtesy 3
    professionalism 3
    respect 3
  end
end
