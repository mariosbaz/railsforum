class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :topics, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :votes, dependent: :destroy
end
