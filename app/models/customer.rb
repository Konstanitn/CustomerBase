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
