class User < ApplicationRecord
  include Gravtastic
  gravtastic
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships
  has_many :received_friendships, class_name: 'Friendship', foreign_key: 'friend_id'


  def friends 
    my_friends = []
    friendships.each {|f| my_friends << f.friend if f.status == "confirmed" }
    received_friendships.each {|f| my_friends << f.user if f.status == "confirmed" }

    my_friends
  end
end
