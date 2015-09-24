class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def resend_invitation
    @user = User.find(params[:user_id])
    @user.invite!
    redirect_to users_path, notice: 'Invite resent'
  end
end
