FactoryGirl.define do 
  factory :cop do
    name "John McClane"
    badge_number 1111
    precinct

    factory :good_cop do
      approval_rating 80
    end

    factory :bad_cop do
      approval_rating 30
    end
  end
end