# frozen_string_literal: true
class EmployeesController < ApplicationController
  before_filter :set_employee, only: [:show, :edit, :update]

  def show
    respond_to do |format|
      format.html
      format.json { render json: @employee }
    end
  end

  def new
    @employee = Employee.new
  end

  def edit; end

  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      redirect_to employee_path(@employee), notice: 'Employee successfully created.'
    else
      @errors = @employee.errors.full_messages
      render :new
    end
  end

  def update
    if @employee.update(employee_params)
      redirect_to employee_path(@employee), notice: 'Employee successfully updated.'
    else
      @errors = @employee.errors.full_messages
      render :edit
    end
  end

  private

  def set_employee
    @employee = Employee.find(params[:id])
  end

  def employee_params
    params.require(:employee).permit(:first_name,
                                     :last_name,
                                     :start_date,
                                     :end_date,
                                     :starting_salary,
                                     :direct_experience,
                                     :indirect_experience,
                                     :billable,
                                     :notes,
                                     :planning_notes)
  end
end
