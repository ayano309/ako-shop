module ApplicationHelper
  def resources_is_user?
    request.fullpath == '/login'
  end
  # URLのパスに相当する部分が/dashboard/loginであればtrueを返す。
end
