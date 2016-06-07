class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def resend_invitation
    @user = User.find(params[:user_id])
    @user.invite!
    redirect_to users_path, notice: 'Invite resent'
  end

  def destroy
    @user = User.find(params[:id])
    msg = @user.destroy ? 'User deleted.' : 'Failed to delete user. Please try again.'
    redirect_to users_path, notice: msg
  end
end
