module Authorization
  extend ActiveSupport::Concern

  included do
    helper_method :require_admin!
  end

  private

  def require_admin!
    # return if user_signed_in? && current_user.admin?

    redirect_to root_path, alert: "You are not authorized to perform this action." unless user_signed_in? && current_user.admin?
  end
end
