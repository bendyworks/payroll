class UsersController < ApplicationController
  before_action :find_user, only: [:set_admin_status, :destroy]
  after_action :verify_authorized

  def index
    @users = User.all
    authorize User
  end

  def resend_invitation
    @user = User.find(params[:user_id])
    @user.invite!
    redirect_to users_path, notice: 'Invite resent'
  end

  def set_admin_status
    if @user.update_attributes admin: (params[:checked] == 'true')
      render json: 'ok'
    else
      alert(@user.email + ' was not set to admin.')
    end
  end

  def destroy
    msg = @user.destroy ? 'User deleted.' : 'Failed to delete user. Please try again.'
    redirect_to users_path, notice: msg
  end

  private

  def find_user
    @user = User.find(params[:id])
  end
end