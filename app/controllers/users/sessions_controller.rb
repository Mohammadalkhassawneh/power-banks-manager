class Users::SessionsController < Devise::SessionsController
  respond_to :json

  def create
    user = User.find_by(email: params[:user][:email])

    if user&.valid_password?(params[:user][:password])
      token = encode_token(user_id: user.id)
      render json: {
        message: 'Logged in successfully.',
        user: {
          id: user.id,
          email: user.email,
          created_at: user.created_at,
          updated_at: user.updated_at,
          role: user.role
        },
        jwt: token
      }
    else
      render json: { error: 'Invalid email or password.' }, status: :unauthorized
    end
  end

  private

  def encode_token(payload)
    JWT.encode(payload, Rails.application.credentials.dig(:devise, :jwt_secret_key))
  end
end
