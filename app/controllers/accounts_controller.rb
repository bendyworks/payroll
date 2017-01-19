# frozen_string_literal: true
class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :edit, :update, :destroy]

  def upload_balances_form
  end

  def upload_balances
    BalanceCsvParser.record params[:balances_file]
    flash.now[:notice] = 'Balances successfully uploaded'
    render :upload_balances_form
  end

  def show
  end

  def new
    @account = Account.new
  end

  def edit
  end

  def create
    @account = Account.new(account_params)

    if @account.save
      redirect_to @account, notice: 'Account was successfully created.'
    else
      render :new
    end
  end

  def update
    if @account.update(account_params)
      redirect_to @account, notice: 'Account was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @account.destroy
    redirect_to root_path, notice: 'Account was successfully destroyed.'
  end

  private

  def set_account
    @account = Account.find(params[:id])
  end

  def account_params
    params.require(:account).permit(:name, :account_type_id)
  end
end
