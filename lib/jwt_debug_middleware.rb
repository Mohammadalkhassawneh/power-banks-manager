class JwtDebugMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    if env['HTTP_AUTHORIZATION'].present?
      token = env['HTTP_AUTHORIZATION'].split(' ').last
      begin
        decoded_token = JWT.decode(token, Rails.application.credentials.dig(:devise, :jwt_secret_key), true, algorithm: 'HS256')
        Rails.logger.info "Decoded JWT: #{decoded_token}"
      rescue JWT::DecodeError => e
        Rails.logger.error "JWT Decode Error: #{e.message}"
      end
    end
    @app.call(env)
  rescue => e
    Rails.logger.error "JWT Error: #{e.message}"
    raise
  end
end
