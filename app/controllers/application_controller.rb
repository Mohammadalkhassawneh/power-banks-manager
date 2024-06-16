class ApplicationController < ActionController::API
  before_action :authenticate_request, unless: :devise_controller?

  include Pundit::Authorization
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  def authorize_admin!
    render json: { error: 'Unauthorized' }, status: :unauthorized unless current_user.admin?
  end

  private

  def authenticate_request
    jwt_payload = decode_jwt
    if jwt_payload.nil?
      render json: { error: 'Unauthorized: Missing or invalid token' }, status: :unauthorized and return
    end

    @current_user = User.find_by(id: jwt_payload['id'])
    if @current_user.nil? || @current_user.jti != jwt_payload['jti']
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  rescue JWT::DecodeError, ActiveRecord::RecordNotFound
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end

  def decode_jwt
    return nil unless request.headers['Authorization'].present?
    token = request.headers['Authorization'].split(' ').last
    JWT.decode(token, Rails.application.credentials.dig(:devise, :jwt_secret_key)).first
  end

  private

  def user_not_authorized
    render json: { error: 'You are not authorized to perform this action' }, status: :forbidden
  end
end
