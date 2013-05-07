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
  	end
end
