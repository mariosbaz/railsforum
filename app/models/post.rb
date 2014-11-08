class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :topic
  has_many :votes, dependent: :destroy
  validates :content, presence: true, length: {maximum: 500}
  validates :user_id, presence: true
  validates :topic_id, presence: true

  def Post.from_users_followed_by(user)
    following_ids = "SELECT followed_id FROM relationships
                     WHERE  follower_id = :user_id"
    where("user_id IN (#{following_ids}) ", user_id: user)
  end

end


