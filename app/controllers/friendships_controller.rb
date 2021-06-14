class FriendshipsController < ApplicationController
  def create
    # friendship = current_user.frienships.build
    if current_user.send_friendship_request(params[:user_id], current_user.id)
      flash[:notice] = 'Friendship request sent'
    else
      flash[:alert] = 'Friendship request not sent'
    end
    redirect_to root_path
  end

  def destroy; end
end
