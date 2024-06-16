class Users::SessionsController < Devise::SessionsController
  respond_to :json

  def create
    user = User.find_by(email: params[:user][:email])

    if user&.valid_password?(params[:user][:password])
      token = encode_token(user)
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

  def destroy
    sign_out(current_user) if user_signed_in?

    head :no_content
  end

  protected

  def respond_to_on_destroy
    head :no_content
  end

  private

  def encode_token(user)
    payload = {
      id: user.id,
      jti: user.jti
    }
    JWT.encode(payload, Rails.application.credentials.dig(:devise, :jwt_secret_key))
  end
end
