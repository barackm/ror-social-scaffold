class Friendship < ApplicationRecord
  before_save :add_default_values

  belongs_to :user
  belongs_to :friend, class_name: 'User', foreign_key: 'friend_id'
  
  validates :status, presence: true

  private

  def friend_with?(user1_id, user2_id)
    "we are friends"
  end

  private

  def add_default_values
    self.status = 'pending' if  self.status != "confirmed"
  end

end
