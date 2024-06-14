class ApplicationController < ActionController::API
  # before_action :authenticate_user!

  def authorize_admin!
    render json: { error: 'Unauthorized' }, status: :unauthorized unless current_user.admin?
  end
end
