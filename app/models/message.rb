class Message < ActiveRecord::Base
  attr_accessible :content, :user_id
  belongs_to :user

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 400 }
  validates :who_sent, presence: true
  default_scope order: "messages.created_at DESC"

end
