module FriendshipsHelper
  def check_buttons(user)
    if Friendship.friend_with?(current_user.id, user.id)
      link_to('Remove', user_friendships_path(user), method: :delete, class: 'control-btn remove')
    elsif current_user.pending_sent_friendship_requests.any? { |f| f.id == user.id }
      link_to('Pending',user_friendships_request_path(user), method: :delete, class: 'control-btn pending')
    elsif current_user.recieved_friendship_requests.any? { |f| f.id == user.id }
      link_to('Reject', user_friendships_request_path(user), method: :delete, class: 'control-btn reject') +
        link_to('Confirm', user_friendship_confirm_path(user), method: :post, class: 'control-btn confirm')
    else
      link_to('Add', user_friendships_path(user), method: :post, class: 'control-btn add')
    end
  end
end
