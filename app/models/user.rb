class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :
  has_attached_file :avatar, :styles => { :medium => "300x300>", :small => "80x80>", mini:"40x40>" }, :default_url => "/assets/avatar_:style.jpg"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :topics, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :votes, dependent: :destroy
end

