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

class User < ActiveRecord::Base
	  attr_accessible :first_name, :last_name, :password, :password_confirmation, :admin
	  has_secure_password
	  has_many :messages, dependent: :destroy

	  before_save :create_remember_token

	  validates :first_name, presence: true, length: { maximum: 50 }
	  validates :last_name, presence: true, length: { maximum: 50 }, uniqueness: true, :uniqueness => { :case_sensitive => false }
	  validates :password, presence: true, length: { minimum: 6 }
	  validates :password_confirmation, presence: true

	private

	def create_remember_token
		self.remember_token = SecureRandom.urlsafe_base64
	end

end
