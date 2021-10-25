# frozen_string_literal: true
class ApplicationController < ActionController::API
  include ActionController::MimeResponds

  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ValidationFailed, with: :validation_failed

  def not_found(e)
    Rails.logger.debug(e)
    render json: { error: e.message }, status: :not_found
  end

  def validation_failed(exception)
    render json: ErrorsSerializer.new(exception.subject), status: :unprocessable_entity
  end
end
