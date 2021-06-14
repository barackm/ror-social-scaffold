class Friendship < ApplicationRecord
  before_save :add_default_values

  belongs_to :user
  belongs_to :friend, class_name: 'User', foreign_key: 'friend_id'
<<<<<<< HEAD
  
  validates :status, presence: true
=======

  def self.friend_with?(user1_id, user2_id)
    friendship = Friendship.where(user_id: user2_id, friend_id: user1_id, status: 'confirmed') ||
                 Friendship.where(user_id: user1_id, friend_id: user2_id, status: 'confirmed')
>>>>>>> 6e24bd5c638483b61ac88b96a980f615d0b2d597

    friendship.empty? ? false : true
  end

<<<<<<< HEAD
  def friend_with?(user1_id, user2_id)
    "we are friends"
=======
  def self.sent_friendship_request?(user1_id, user2_id)
    friendship = Friendship.where(user_id: user2_id, friend_id: user1_id, status: 'pending') ||
                 Friendship.where(user_id: user1_id, friend_id: user2_id, status: 'pending')

    friendship.empty? ? false : true
>>>>>>> 6e24bd5c638483b61ac88b96a980f615d0b2d597
  end

  private

  def add_default_values
    self.status = 'pending' if status != 'confirmed'
  end
end
