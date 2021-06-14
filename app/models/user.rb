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
    friendships.each { |f| my_friends << f.friend if f.status == 'confirmed' }
    received_friendships.each { |f| my_friends << f.user if f.status == 'confirmed' }

    my_friends
  end

  def pending_sent_friendship_requests
    my_friends = []
    friendships.each { |f| my_friends << f.friend if f.status == 'pending' }

    my_friends
  end

  def send_friendship_request(friend_id, current_user_id)
    friend = friendships.build(friend_id: friend_id)
    friend.save unless Friendship.sent_friendship_request?(current_user_id, friend_id)
  end

  def recieved_friendship_requests
    my_friends = []
    received_friendships.each { |f| my_friends << f.user if f.status == 'pending' }

    my_friends
  end
end
