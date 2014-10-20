FactoryGirl.define do 
  factory :cop do
    name "John McClane"
    badge_number 1111
    precinct

    factory :good_cop do
      approves 3
      disapproves 1
    end

    factory :bad_cop do
      approves 1
      disapproves 3
    end
  end


  factory :homeless_cop, class: Cop do
    name "Riggs"
    badge_number 4444
  end
  
end