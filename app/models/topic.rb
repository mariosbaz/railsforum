class Topic < ActiveRecord::Base
  belongs_to :user
  has_many :posts, dependent: :destroy
  validates :name, presence: true, length: {maximum: 15}
  validates :user_id, presence: true
end
