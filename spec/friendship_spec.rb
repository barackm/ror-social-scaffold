require 'rails_helper'

# rubocop:disable Lint/UselessAssignment

RSpec.describe Friendship, type: :model do
  describe 'associations' do
    it { should belong_to(:user).class_name('User') }
    it { should belong_to(:friend).class_name('User') }

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

  describe 'validations' do
    it { should validate_presence_of(:status) }
  end
end

# rubocop:enable Lint/UselessAssignment
