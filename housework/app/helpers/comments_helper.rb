module CommentsHelper
  def nested_comments(comments, level = 0)
    comments.map do |comment|
      content_tag(:div, comment.parent && level == 0 ? nil : render(comment), :class => "row-fluid")
    end.join.html_safe
  end
end