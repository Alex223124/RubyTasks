module TasksHelper
  def is_there_mark_for_task?
    @task.finishing? && current_user.eql?(@task.user) && !@task.mark
  end

  def can_change_task?
    current_user.eql?(@task.user) || (current_user.has_role?(:parent) && @task.user.parents.exists?(current_user))
  end
end