# frozen_string_literal: true
class ApplicationController < ActionController::API
  include ActionController::MimeResponds

  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ValidationFailed, with: :validation_failed
  rescue_from ActionController::ParameterMissing, with: :missing_params

  def not_found(e)
    Rails.logger.debug(e)
    render json: { error: e.message }, status: :not_found
  end

  def validation_failed(exception)
    render json: ErrorsSerializer.new(exception.subject), status: :unprocessable_entity
  end

  def missing_params
    render json: {}, status: :bad_request
  end

  private
  # Validates the token and user and sets the @current_user scope
  def authenticate_request!
    if !payload || !JsonWebToken.valid_payload(payload.first)
      return invalid_authentication
    end

    load_current_user!
    invalid_authentication unless @current_user
  end

  # Returns 401 response. To handle malformed / invalid requests.
  def invalid_authentication
    render json: { error: 'Invalid Request' }, status: :unauthorized
  end

  # Deconstructs the Authorization header and decodes the JWT token.
  def payload
    auth_header = request.headers['Authorization']
    token = auth_header.split(' ').last
    JsonWebToken.decode(token)
  rescue
    nil
  end

  # Sets the @current_user with the user_id from the payload
  def load_current_user!
    @current_user = User.find_by(id: payload[0]['user_id'])
  end
end
