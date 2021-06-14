module FriendshipsHelper
  def check_buttons(user)
    if Friendship.friend_with?(current_user.id, user.id)
      link_to('Remove', user_path(user), class: 'remove')
    elsif current_user.pending_sent_friendship_requests.any? { |f| f.id == user.id }
      link_to('Pending', user_path(user), class: 'pending')
    elsif current_user.recieved_friendship_requests.any? { |f| f.id == user.id }
      link_to('Reject', user_path(user), class: 'reject') +
        link_to('Confirm', user_path(user), class: 'confirm')
    else
      link_to('Add', user_path(user), class: 'add')
    end
  end
end
