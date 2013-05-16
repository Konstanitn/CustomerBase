# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  first_name      :string(255)
#  last_name       :string(255)
#  password_digest :string(255)
#  admin           :boolean
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  remember_token  :string(255)
#

require 'spec_helper'

describe User do
	
	before {@user=User.new(first_name:"Alen", last_name: "Delon", password: "password",
		password_confirmation: "password")}
	subject {@user}

	it { should respond_to(:first_name) }
	it { should respond_to(:last_name) }
	it { should respond_to(:password) }
	it { should respond_to(:password_confirmation) }
	it { should respond_to(:admin) }
	it { should respond_to(:remember_token) }
	it { should respond_to(:authenticate) }
	it { should respond_to(:messages) }

	it { should be_valid }
	it { should_not be_admin}

	describe " when admin = true" do
		before do
			@user.save!
			@user.toggle! (:admin)
		end

		it{ should be_admin }
	end

	describe "when first_name is not present" do
		before {@user.first_name = " "}
		it {should_not be_valid }
	end

	describe "when last_name is not present" do
		before {@user.last_name = " "}
		it {should_not be_valid }
	end

	describe "when password is not present" do
		before {@user.password = " "}
		it {should_not be_valid }
	end

	describe "when password_confirmation is not present" do
		before {@user.password_confirmation = " "}
		it {should_not be_valid }
	end

	describe "when first_name is not present" do
		before {@user.first_name = " "}
		it {should_not be_valid }
	end

	describe "when password != password_confirmation" do
		before {@user.password_confirmation = " 111111 "}
		it {should_not be_valid }
	end

	describe "when first_name is too long" do
		before {@user.first_name = "a"*51}
		it {should_not be_valid }
	end

	describe "when last_name is too long" do
		before {@user.last_name = "a"*51}
		it {should_not be_valid }
	end

	describe "when password is too short" do
		before {@user.password = "a"*5}
		it {should_not be_valid }
	end

	describe "when last_name has been taken" do
		before do
			@user_with_the_same = @user.dup
			@user_with_the_same.save
		end

		it { should_not be_valid}
	end

	# Аутентификация

	describe "Autenticate" do
		before do
			@user.save
		end
		let(:found_user) {User.find_by_last_name(@user.last_name)}

		describe "with valid password" do
			it {should == found_user.authenticate(@user.password)}
		end

		describe "with invalid password" do
			it { should_not == found_user.authenticate("Invalid_pass") }
		end
	end

	describe "remember token should_not be empty after saving" do
		before { @user.save }

		its(:remember_token) {should_not be_blank}
	end

end