# frozen_string_literal: true

class SalariesController < ApplicationController
  before_action :set_employee, except: [:edit, :update, :destroy]
  before_action :set_salary, only: [:edit, :update, :destroy]

  def new
    salaries_count = last_tenure.salaries.count
    @salary = last_tenure.salaries.new
    # pre-fill start date from tenure for first salary to help user
    @salary.start_date = last_tenure.start_date if salaries_count == 0
  end

  def create
    update_params = salary_params
    update_params["start_date"] = @employee.tenures.last.start_date unless update_params.dig(:start_date)
    @salary = @employee.tenures.last.salaries.new(update_params)
    if @salary.save
      redirect_to employee_path(@employee), notice: 'Successfully recorded raise'
    else
      render :new
    end
  end

  def edit; end

  def update
    update_params = salary_params
    update_params["start_date"] = @salary.tenure.start_date unless update_params.dig(:start_date)
    if @salary.update(update_params)
      redirect_to employee_path(@salary.employee), notice: 'Successfully upddated salary'
    else
      render :edit
    end
  end

  def destroy
    msg = @salary.destroy ? 'Salary deleted.' : 'Failed to delete salary. Please try again.'
    redirect_to employee_path(params[:employee_id]), notice: msg
  end

  private

  def set_employee
    @employee = Employee.find(params[:employee_id])
  end

  def set_salary
    @salary = Salary.find(params[:id])
  end

  def last_tenure
    @employee.tenures.last
  end

  def salary_params
    params.require(:salary).permit(:start_date, :annual_amount)
  end
end
