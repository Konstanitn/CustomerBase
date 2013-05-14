# == Schema Information
#
# Table name: messages
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  content    :text
#  who_sent   :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Message < ActiveRecord::Base
  attr_accessible :content, :user_id
  belongs_to :user

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 400 }
  validates :who_sent, presence: true
  default_scope order: "messages.created_at DESC"

end
