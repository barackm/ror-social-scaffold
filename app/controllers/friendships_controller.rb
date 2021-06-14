class FriendshipsController < ApplicationController
  def create
    if current_user.send_friendship_request(params[:user_id], current_user.id)
      flash[:notice] = 'Friendship request sent'
    else
      flash[:alert] = 'Friendship request not sent'
    end
    redirect_to root_path
  end

  def destroy_invitation
    friendship = current_user.received_friendships.find_by(user_id: params[:user_id], status:"pending") ||
    current_user.friendships.find_by(friend_id: params[:user_id], status:"pending")
    
    if(friendship && friendship.destroy)
      flash[:notice] = 'Friendship removed.'
      redirect_to root_path  
    else
      flash[:alert] = 'Friendship not removed.'
      redirect_to root_path
    end
  end

  def destroy
    friendship = current_user.received_friendships.find_by(user_id: params[:user_id], status:"confirmed") ||
    current_user.friendships.find_by(friend_id: params[:user_id], status:"confirmed")
    
    if(friendship && friendship.destroy)
      flash[:notice] = 'Friendship removed.'
      redirect_to root_path  
    else
      flash[:alert] = 'Friendship not removed.'
      redirect_to root_path
    end
  end

  def confirm 
    friendship = current_user.received_friendships.find_by(user_id: params[:user_id], status:"pending")
    if(friendship && friendship.update(status: "confirmed"))
      flash[:notice] = 'Friendship confirmed.'
      redirect_to root_path
    else 
      flash[:alert] = 'Friendship not confirmed.'
      redirect_to root_path
    end
  end
end
