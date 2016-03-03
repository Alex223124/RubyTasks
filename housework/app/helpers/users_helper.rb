module UsersHelper
  ONE_DAY = 86400

  def is_member_of_family?(user)
    current_user.parents.exists?(user) || current_user.children.exists?(user) || current_user.eql?(user)
  end

  def is_unappreciated?(task)
    task.estimation.end_time - task.end_time < ONE_DAY
  end

  def is_overvalued?(task)
    task.end_time - task.estimation.end_time < ONE_DAY
  end

  def to_bool(str)
    if str == "true"
      true
    else
      false
    end

  end

  def private?(user, attr)
    to_bool(user.privacy[attr]) || current_user.eql?(user)
  end

end