class Api::V1::SessionsController < Api::ApplicationController
  before_action :authenticate_user!, only: :destroy

  def create
    user = User.find_for_database_authentication(email: user_params[:email])
    if user.present? && user.valid_password?(user_params[:password])
      sign_in(user)
      render json: user.reload
    else
      render status: :unauthorized,
      json: I18n.t('devise.sessions.invalid').to_json
    end
  end

  def destroy
    @user.assign_auth_token!
    render json: I18n.t('devise.sessions.user.signed_out').to_json
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def sign_in(user)
    user.current_sign_in_ip = request.remote_ip
    user.current_sign_in_at = Time.current
    user.assign_auth_token!
  end
end
