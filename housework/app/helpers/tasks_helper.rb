module TasksHelper
  def is_there_mark_for_task?
    @task.finishing? && current_user.eql?(@task.user) && !@task.mark
  end
end