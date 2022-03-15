# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :verify_admin, only: [:set_admin_status, :destroy, :resend_invitation]
  before_action :find_user, only: [:set_admin_status, :destroy]

  def index
    @users = User.all
  end

  def resend_invitation
    @user = User.find(params[:user_id])
    @user.invite!
    redirect_to users_path, notice: 'Invite resent'
  end

  def set_admin_status
    if @user.update admin: (params[:checked] == 'true')
      redirect_to users_path, notice: "The admin status has been updated for the user with email: #{@user.email}."
    else
      redirect_to users_path, notice: "Unable to update admin status for the user with email: #{@user.email}."
    end
  end

  def destroy
    msg = @user.destroy ? 'User deleted.' : 'Failed to delete user. Please try again.'
    redirect_to users_path, notice: msg
  end

  private

  def verify_admin
    if !current_user.admin
      redirect_to users_path, notice: 'You do not have permission to update that record.'
    end
  end

  def find_user
    @user = User.find(params[:id])
  end
end