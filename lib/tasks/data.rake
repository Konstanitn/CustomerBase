namespace :db do 
	desc "Erase Fill database with data"

	Rake::Task['db:reset'].invoke

	task populate: :environment do

		# Создание админа
		admin = User.create!(first_name: "Customer",
							last_name: "Base",
							password: "customer",
							password_confirmation: "customer")
		admin.toggle!(:admin)

		# Создание первого менеджера
		admin = User.create!(first_name: "Sasha",
							last_name: "Koen",
							password: "password",
							password_confirmation: "password")
		
		# Создание пользователей
		50.times do |n|
			password = "password"
			User.create!(first_name: Faker::Name.first_name,
						last_name: "LastName_#{n+1}",
						password: password,
						password_confirmation: password)
		end

		# Создание заказчиков (клиентов)
		50.times do |c|
			Customer.create!(first_name: Faker::Name.first_name,
							last_name: Faker::Name.last_name,
							middle_name: Faker::Name.last_name,
							phone_number: Faker::PhoneNumber.phone_number,
							address: "Russia, Samara",
							info: Faker::Lorem.sentence(3),
							who_updated: User.find_by_last_name("Base").last_name)
		end
		# Создание сообщений между первыми двумя пользователями
		user_1 = User.find_by_last_name("Base")
		user_2 = User.find_by_last_name("Koen")
		50.times do |n|
			mes_1 = user_1.messages.new
			mes_2 = user_2.messages.new
			# и-за того что атрибут who_sent являеться закрытым, пришлось таким кодом создавать через save, а не create.
			mes_1.who_sent = user_2.last_name
			mes_2.who_sent = user_1.last_name
			mes_1.content = Faker::Lorem.sentence(5)
			mes_2.content = Faker::Lorem.sentence(5)
			mes_1.save
			mes_2.save			
		end
	end
end