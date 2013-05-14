require 'spec_helper'

describe "StaticPages" do
  
  subject { page }

	describe "Home page" do
  		before { visit root_path }

  		it { should have_selector('h1', text: 'Home') }
  		it { should_not have_selector('title', text: 'Home') }
 	end

 	describe "About page" do
 		before { visit about_path }

  		it { should have_selector('h1', text: 'About') }
  		it { should have_selector('title', text: 'About') }
  end

  describe "Contacts page" do
    before { visit contacts_path }

      it { should have_selector('h1', text: 'Contacts') }
      it { should have_selector('title', text: 'Contacts') }
  end

  # проверка куда ведут статические страницы
  	it "Links should be right" do
  		visit root_path

  		click_link "Home" 
  		should have_selector 'title', text: 'CustomerBase'
  		click_link "About"
  		should have_selector 'title', text:'CustomerBase > About' 
      click_link "Contacts"
      should have_selector 'title', text:'CustomerBase > Contacts' 
  		click_link "CustomerBase"
  		should have_selector 'title', text: 'CustomerBase'
      click_link "Sign in"
      should have_selector 'title', text: 'Sign in'
      
  	end
    # проверка что залогинившиеся пользователи видят правильные ссылки
   describe "Signed in user should see right links" do
     let(:user) {FactoryGirl.create(:user)}
     let(:admin) {FactoryGirl.create(:admin)}

      describe "signed like Manager" do
        before { sign_in user }

        it { should have_link('CustomerBase', href: root_path) }
        it { should have_link('Home', href: root_path) }
        it { should have_link('About', href: about_path) }
        it { should have_link('Contacts', href: contacts_path) }
        it { should have_link('All users', href: users_path) }
        it { should have_link('Create customer', href: newcustomer_path) }
        it { should have_link('All customers', href: customers_path) }
        it { should have_link('My messages', href: mymessages_path) }
        it { should have_link('Sign out', href: signout_path) }
        it { should_not have_link('Sign up', href: signup_path) } # Менеджер не должен создавать пользователей
        it { should_not have_link('Sign in', href: signin_path) }
      end

      describe "signed like Admin" do
        before { sign_in admin }

        it { should have_link('Home', href: root_path) }
        it { should have_link('About', href: about_path) }
        it { should have_link('Contacts', href: contacts_path) }
        it { should have_link('CustomerBase', href: root_path) }
        it { should have_link('Create user', href: signup_path) }
        it { should have_link('All users', href: users_path) }
        it { should have_link('Create customer', href: newcustomer_path) }
        it { should have_link('All customers', href: customers_path) }
        it { should have_link('My messages', href: mymessages_path) }
        it { should have_link('Sign out', href: signout_path) }
        it { should_not have_link('Sign in', href: signin_path) }
      
      end
   end
   # проверка что НЕ залогинившиеся пользователи видят правильные ссылки
  describe "Not signed in user should see right links" do
      before {visit root_path}

      it { should have_link('CustomerBase', href: root_path) }
      it { should have_link('Home', href: root_path) }
      it { should have_link('About', href: about_path) }
      it { should have_link('Contacts', href: contacts_path) }
      it { should have_link('Sign in', href: signin_path) }
      it { should_not have_link('Create user', href: signup_path) }
      it { should_not have_link('All users', href: users_path) }
      it { should_not have_link('Create customer', href: newcustomer_path) }
      it { should_not have_link('All customers', href: customers_path) }
      it { should_not have_link('My messages', href: mymessages_path) }
      it { should_not have_link('Sign out', href: signout_path) }

  end
      
end
