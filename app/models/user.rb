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
  has_many :received_friendships, -> { where status: 'pending' }, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :pending_friends, through: :received_friendships, source: :user

  has_many :sent_friendships, -> { where status: 'pending' }, class_name: 'Friendship', foreign_key: 'user_id'
  has_many :requested_friends, through: :sent_friendships, source: :friend

  has_many :confirmed_friendships, -> { where status: 'confirmed' }, class_name: 'Friendship'
  has_many :friends, through: :confirmed_friendships

  def send_friendship_request(user_id)
    friend = Friendship.new(user_id: id, friend_id: user_id)
    friend.save
  end

  def friends_and_own_posts
    Post.where(user: (friends.to_a << self))
    # This will produce SQL query with IN. Something like: select * from posts where user_id IN (1,45,874,43);
  end
end
