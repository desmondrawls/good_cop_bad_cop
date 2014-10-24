FactoryGirl.define do 
	factory :comment do
		title "Bad Breath"
		text "Keep your distance."
		author "Easy-e"
	end

	factory :good_comment, :class => Comment do
		title "Helpful"
		text "He gave me directions to the hospital."
		author "Charles Manson"
	end
end