FactoryGirl.define do 
  factory :cop do
    name "John McClane"
    sequence(:badge_number, 1000)
    precinct

    factory :good_cop do
      name "Murtaugh"
      approves 3
      disapproves 1
    end

    factory :neutral_cop do
      name "Robo Cop"
      approves 10
      disapproves 10
    end

    factory :bad_cop do
      name "Riggs"
      approves 1
      disapproves 3
    end
  end


  factory :homeless_cop, class: Cop do
    name "Popeye"
    badge_number 4444
  end
  
end