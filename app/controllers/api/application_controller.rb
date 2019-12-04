module Api
  class ApplicationController < ActionController::API
    respond_to :json

    rescue_from ActiveRecord::RecordNotFound do |e|
      render json: { errors: [{ title: "404 Not Found", detail: "Couldn't find '#{e.model}'" }] }, status: 404
    end

    def authenticate_user!
      token = request.env['HTTP_USER_TOKEN']
      @user = User.find_by!(auth_token: token)
    end
  end
end
