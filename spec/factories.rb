FactoryGirl.define  do 
	factory :user do
		sequence(:first_name) {|n| "person_#{n}"}
		sequence(:last_name) {|n| "LastNameTest_#{n}"}
		password "password"
		password_confirmation "password"

		factory :admin do
			admin true
		end
	end

	factory :message do
			content "Hello! #{n}"
			user
	end
	
end