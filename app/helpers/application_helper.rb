module ApplicationHelper
  def menu_link_to(link_text, link_path)
    class_name = current_page?(link_path) ? 'menu-item active' : 'menu-item'

    content_tag(:div, class: class_name) do
      link_to link_text, link_path
    end
  end

  def like_or_dislike_btn(post)
    like = Like.find_by(post: post, user: current_user)
    if like
      link_to("<i class='bi bi-heart-fill liked-icon'></i> Dislike".html_safe,
              post_like_path(id: like.id, post_id: post.id), method: :delete)
    else
      link_to("<i class='bi bi-heart'></i> Like".html_safe, post_likes_path(post_id: post.id), method: :post)
    end
  end
end
