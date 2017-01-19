# frozen_string_literal: true
class SalariesController < ApplicationController
  def new
    employee = Employee.find(params[:employee_id])
    @salary = employee.salaries.new
  end

  def create
    employee = Employee.find(params[:employee_id])
    @salary = employee.salaries.new(salary_params)
    if @salary.save
      redirect_to employee_path(@salary.employee), notice: 'Successfully recorded raise'
    else
      render :new
    end
  end

  def destroy
    @salary = Salary.find(params[:id])
    msg = @salary.destroy ? 'Salary deleted.' : 'Failed to delete salary. Please try again.'
    redirect_to employee_path(params[:employee_id]), notice: msg
  end

  private

  def salary_params
    params.require(:salary).permit(:start_date, :annual_amount)
  end
end
