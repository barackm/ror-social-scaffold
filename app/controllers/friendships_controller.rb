class FriendshipsController < ApplicationController
  def create
    if current_user.send_friendship_request(params[:user_id])
      flash[:notice] = 'Friendship request sent'
    else
      flash[:alert] = 'Friendship request not sent'
    end
    redirect_to root_path
  end

  def destroy_invitation
    friendship = current_user.received_friendships.find_by(user_id: params[:user_id], status: 'pending') ||
                 current_user.sent_friendships.find_by(friend_id: params[:user_id], status: 'pending')

    if friendship&.destroy
      flash[:notice] = 'Friendship removed.'
    else
      flash[:alert] = 'Friendship not removed.'
    end
    redirect_to root_path
  end

  def destroy
    friendship1 = Friendship.find_by(user_id: params[:user_id], friend_id: current_user.id, status: 'confirmed')
    friendship2 = Friendship.find_by(user_id: current_user.id, friend_id: params[:user_id], status: 'confirmed')

    if friendship1 && friendship2
      friendship1.destroy
      friendship2.destroy

      flash[:notice] = 'Friendship removed.'
    else
      flash[:alert] = 'Friendship not removed.'
    end

    redirect_to root_path
  end

  def confirm
    friendship = current_user.received_friendships.find_by(user_id: params[:user_id], status: 'pending')
    if friendship.confirm_friend
      flash[:notice] = 'Friendship confirmed.'
    else
      flash[:alert] = 'Friendship not confirmed.'
    end
    redirect_to root_path
  end
end
