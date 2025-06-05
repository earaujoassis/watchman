class ApplicationController < ActionController::API
  def health
    render json: { status: "ok", timestamp: Time.current }
  end

  private

  def render_json_error(message, status = :unprocessable_entity)
    render json: { error: message }, status: status
  end

  def render_json_success(data, status = :ok)
    render json: data, status: status
  end
end
