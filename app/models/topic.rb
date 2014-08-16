class Topic < ActiveRecord::Base
  belongs_to :user
  validates :name, presence: true, length: {maximum: 15}
  validates :user_id, presence: true;
end
