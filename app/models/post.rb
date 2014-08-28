class Post < ActiveRecord::Base
	belongs_to :user
	belongs_to :topic
	validates :content, presence: true, length: {maximum: 300}
	validates :user_id, presence: true
	validates :topic_id, presence: true
end
