class Friendship < ApplicationRecord
  before_save :add_default_values

  belongs_to :user
  belongs_to :friend, class_name: 'User', foreign_key: 'friend_id'

  def self.friend_with?(user1_id, user2_id)
    friendship = Friendship.where(user_id: user2_id, friend_id: user1_id, status: 'confirmed') ||
                 Friendship.where(user_id: user1_id, friend_id: user2_id, status: 'confirmed')

    friendship.empty? ? false : true
  end

  def self.sent_friendship_request?(user1_id, user2_id)
    friendship = Friendship.where(user_id: user2_id, friend_id: user1_id, status: 'pending') ||
                 Friendship.where(user_id: user1_id, friend_id: user2_id, status: 'pending')

    friendship.empty? ? false : true
  end

  def confirm_friend
    update(status: 'confirmed')
    Friendship.create!(friend_id: user_id,
                       user_id: friend_id,
                       status: 'confirmed')
  end

  private

  def add_default_values
    self.status = 'pending' if status != 'confirmed'
  end
end
