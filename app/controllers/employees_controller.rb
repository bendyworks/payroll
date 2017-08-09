# frozen_string_literal: true

class EmployeesController < ApplicationController
  before_filter :set_employee, only: [:show, :edit, :update]

  def show; end

  def new
    @employee = Employee.new
  end

  def edit; end

  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      redirect_to @employee, notice: 'Employee successfully created.'
    else
      @errors = @employee.errors.full_messages
      render :new
    end
  end

  def update
    respond_to do |format|
      if @employee.update(employee_params)
        format.html { redirect_to @employee, notice: 'Employee successfully updated.' }
      else
        format.html do
          @errors = @employee.errors.full_messages
          render :edit
        end
      end
      format.json { respond_with_bip(@employee) }
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
                                     :planning_raise_date,
                                     :planning_raise_salary,
                                     :planning_notes)
  end
end
