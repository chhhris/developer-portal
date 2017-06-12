class ErrorsController < ActionController::API
  def not_found
    render json: { error: '404 not found'}.as_json, status: 404
  end

  def exception
    render json: { error: '500 Internal Server Error'}.as_json, status: 500
  end
end
