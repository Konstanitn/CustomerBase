require 'spec_helper'

describe "User pages" do

	subject {page}
	
	# Проверка появления информации о сообщениях
	describe "Messages: when user" do
		before do 
			@newuser = FactoryGirl.create(:user)
			@newuser.save
		end

		# Оповещение если нет сообщений
		describe "has no message" do
			before do
				sign_in @newuser
				visit root_path
			end

			it {should have_selector('div.info', text: 'You have no messages')}
		end

		# Проверка появления ссылки на сообщения если они есть у пользователя и проверка пагинайции(!временно не работает!)
		describe "has messages, it should " do
			before do
				20.times do |n|
					@message = @newuser.messages.new(content: "Hello #{n+1}!")
					@message.who_sent = "Base"
					@message.save
				end
			end

			describe "be link in .info block" do
				before {sign_in @newuser}				
				it {should have_link("#{@newuser.messages.count} messages", href: mymessages_path)}
			end
		

			describe "have pagination of messages >" do
				before do
					sign_in @newuser
					visit mymessages_path				
				end

				it { should have_selector('div.pagination') }
				
				it "it should list each message" do
					@newuser.messages.paginate(page: 1, per_page: 10).each do |message|
						page.should have_selector('li', text: message.content)
					end
				end
			end
		end
	end

	# проверка видимости страницы создания пользователей
 	describe "Create user page:" do
		let(:user) {FactoryGirl.create(:user)}
		let(:admin) {FactoryGirl.create(:admin)}

		describe "Manager should not be alowed to see this page" do
			before do
				sign_in user
				get signup_path
			end
			specify { response.should redirect_to(root_path) }
		end

		describe "Admin should be alowed to see this page" do
			before do
				sign_in admin
				visit signup_path
			end
			it {should have_selector('h1', text: 'new user')}
		end
	end

	# проверка видимости страницы правки пользователей
	describe "Edit user page:" do
		let(:user) {FactoryGirl.create(:user)}
		let(:admin) {FactoryGirl.create(:admin)}

		describe "Manager should not be alowed to see this page" do
			before do
				sign_in user
				get edit_user_path(user)
			end
			specify { response.should redirect_to(root_path) }
		end

		describe "Admin should be alowed to see this page" do
			before do
				sign_in admin
				visit edit_user_path(user)
			end
			it { should have_selector('h1', text: 'Edit user') }
		end
	end

	# проверка ссылок на странице All users и пагинации на этой странице
	describe "All users page:" do
		let(:user) {FactoryGirl.create(:user)}
		let(:admin) {FactoryGirl.create(:admin)}
		

		describe "Manager should see " do
			before do
				sign_in user
				visit users_path
			end
			it 'only links SendMessage' do
				User.paginate(page: 1, per_page: 10).each do |user|
					page.should_not have_link('Delete', href: user_path(user))
					page.should_not have_link('Edit', href: edit_user_path(user))
					page.should have_link('Send message', href: newmessage_path(:id => user))
				end
			end
		end

		describe "Admin should see " do
			before do
				sign_in admin
				visit users_path
			end
			it "links 'Delete', 'Edit', 'Send message'" do
				User.paginate(page: 1, per_page: 10).each do |user|
					if user.last_name != "Base" # нельзя удалять или править аккаунт CustomerBase 
						page.should have_link('Delete', href: user_path(user)) 
						page.should have_link('Edit', href: edit_user_path(user))
					end
					page.should have_link('Send message', href: newmessage_path(:id => user))
				end
			end
		end
	end
	
	# Никто не должен суметь удалить пользователя CustomerBase

	describe "CustomerBase's profile shouldn't be deleted by " do
		let(:user) {FactoryGirl.create(:user)}
		let(:admin) {FactoryGirl.create(:admin)}
		
		describe "not signed in person" do
			before { delete user_path(User.find_by_last_name("Base")) }
			specify { response.should redirect_to(root_path) }	
		end

		describe "Manager" do
			before do
				sign_in user
				delete user_path(User.find_by_last_name("Base")) 
			end
			specify { response.should redirect_to(root_path) }	
		end
			
		describe "Admin " do
			before {sign_in admin}
			it 'too' do
				expect {delete user_path(User.find_by_last_name("Base"))}.not_to change(User, :count)	
	        end
		end
	end
end