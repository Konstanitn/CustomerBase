class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  # Force signout to prevent CSRF attacks
def handle_unverified_request
    sign_out
    super
  end
end
# Фильтр для контроллеров проверяющий вошел ли полльзователь или нет
def signed_in_user
  render file: "public/403", status: 403, layout: false unless signed_in?
end

private
 
  def record_not_found
    render file: "public/404", status: 404, layout: false
  end

