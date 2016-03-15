module CommentsHelper
  def nested_comments(comments, level = 0)
    comments.map do |comment|
      content_tag(:div, comment.parent && level == 0 ? nil : render(comment), 'data-comment': comment.id, class: "comment-item", id: comment.id.to_s + '_c')
    end.join.html_safe
  end
end