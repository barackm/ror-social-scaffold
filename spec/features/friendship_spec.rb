require 'rails_helper'

# rubocop:disable Lint/UselessAssignment

RSpec.describe Friendship, type: :model do
  describe 'associations' do
    it { should belong_to(:user).class_name('User') }
    it { should belong_to(:friend).class_name('User') }

    it 'returns true if two given users are friends' do
      user1 = User.create(email: 'user1@gmail.com', password: 'password', name: 'User1')
      user2 = User.create(email: 'user2@gmail.com', password: 'password', name: 'User2')
      invitation = Friendship.create(user_id: user1.id, friend_id: user2.id, status: 'confirmed')
      expect(invitation.status).to eq('confirmed')
    end

    it 'returns false if there is a pending invitation of two given users' do
      user1 = User.create(email: 'user1@gmail.com', password: 'password', name: 'User1')
      user2 = User.create(email: 'user2@gmail.com', password: 'password', name: 'User2')
      invitation = user1.friendships.create(friend_id: user2.id)
      expect(Friendship.sent_friendship_request?(user1.id, user2.id)).to eq(false)
    end

    it 'returns true if a given user is in the list of another user friend' do
      user1 = User.create(email: 'user1@gmail.com', password: 'password', name: 'User1')
      user2 = User.create(email: 'user2@gmail.com', password: 'password', name: 'User2')
      invitation = Friendship.create(user_id: user1.id, friend_id: user2.id, status: 'confirmed')
      friends = user1.friends[0].id == user2.id
      expect(friends).to eq(true)
    end

    it 'returns true if a given user is NOT in the list of another user friend' do
      user1 = User.create(email: 'user1@gmail.com', password: 'password', name: 'User1')
      user2 = User.create(email: 'user2@gmail.com', password: 'password', name: 'User2')
      invitation = Friendship.create(user_id: user1.id, friend_id: user2.id, status: 'pending')
      friends = user1.friends[0]&.id == user2.id
      expect(friends).to eq(false)
    end

    it 'returns false if a given user recieves a friend request' do
      user1 = User.create(email: 'user1@gmail.com', password: 'password', name: 'User1')
      user2 = User.create(email: 'user2@gmail.com', password: 'password', name: 'User2')
      invitation = Friendship.create(user_id: user1.id, friend_id: user2.id, status: 'pending')
      friends = user2.received_friendships[0].id == user1.id
      expect(friends).to eq(false)
    end

    it 'returns false if a given user DID NOT recieve a friend request' do
      user1 = User.create(email: 'user1@gmail.com', password: 'password', name: 'User1')
      user2 = User.create(email: 'user2@gmail.com', password: 'password', name: 'User2')
      invitation = Friendship.create(user_id: user1.id, friend_id: user2.id, status: 'confirmed')
      friends = user2.received_friendships[0]&.id == user1.id
      expect(friends).to eq(false)
    end

    context 'if user exists but not the friend' do
      it 'should not save the friendship' do
        u1 = User.create(name: 'seba', email: 's@gmail.com', password: 'password')
        u2 = User.create(name: 'baraka', email: 'b@gmail.com', password: 'password')
        friendship = Friendship.new(user_id: u1.id, friend_id: 'c', status: 'pending')
        expect(friendship.save).to eq(false)
      end
    end

    context 'if friend exists but not the user' do
      it 'should not save the friendship' do
        u1 = User.create(name: 'seba', email: 's@gmail.com', password: 'password')
        u2 = User.create(name: 'baraka', email: 'b@gmail.com', password: 'password')
        friendship = Friendship.new(user_id: 'c', friend_id: u2.id, status: 'pending')
        expect(friendship.save).to eq(false)
      end
    end

    context 'friend and user exist' do
      it 'should save the friendship' do
        u1 = User.create(name: 'seba', email: 's@gmail.com', password: 'password')
        u2 = User.create(name: 'baraka', email: 'b@gmail.com', password: 'password')
        friendship = Friendship.new(user_id: u1.id, friend_id: u2.id, status: 'pending')
        expect(friendship.save).to eq(true)
      end
    end
  end
end

# rubocop:enable Lint/UselessAssignment
