class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def go_to(resource_or_action)
    case resource_or_action
    when Symbol then
      render resource_or_action
    else
      redirect_to resource_or_action
    end
  end

  alias_method :display_error, :go_to
end
