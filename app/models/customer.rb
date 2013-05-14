# == Schema Information
#
# Table name: customers
#
#  id           :integer          not null, primary key
#  first_name   :string(255)
#  last_name    :string(255)
#  middle_name  :string(255)
#  phone_number :string(255)
#  address      :string(255)
#  info         :text
#  who_updated  :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Customer < ActiveRecord::Base
	attr_accessible :address, :first_name, :info, :last_name, :middle_name, :phone_number, :who_updated


	
	validates :first_name, presence: true, length: { maximum: 50 }
	validates :last_name, presence: true, length: { maximum: 50 }
	validates :middle_name, presence: true, length: { maximum: 50 }  
	validates :phone_number, length: { maximum: 50 }
	validates :address, length: { maximum: 100 }
	validates :info, length: { maximum: 500}

	#VALID_REGEX_OF_PH_NOMBER=''
	#validates :phone_number

end
