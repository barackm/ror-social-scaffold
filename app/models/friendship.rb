class Friendship < ApplicationRecord
    before_save :add_default_values

    belongs_to :user 
    belongs_to :friend, class_name: "User", foreign_key: "friend_id"
    
    private
    def add_default_values
        self.status = "pending"
    end
end
