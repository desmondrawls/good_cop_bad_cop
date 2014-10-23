# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :rating do
    courtesy 3
    professionalism 3
    respect 3
  end

  factory :bad_rating, class: Rating do
  	courtesy 1
  	professionalism 2
  	respect 1
  end

  factory :good_rating, class: Rating do
  	courtesy 4
  	professionalism 5
  	respect 5
  end

  factory :partial_rating, class: Rating do
  	professionalism 2
  end
end
