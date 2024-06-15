class ApplicationController < ActionController::API
  before_action :authenticate_user!
  include Pundit::Authorization

  def authorize_admin!
    render json: { error: 'Unauthorized' }, status: :unauthorized unless current_user.admin?
  end
end
