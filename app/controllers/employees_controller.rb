class EmployeesController < ApplicationController

  def show
    @employee = Employee.find(params[:id])
  end

  def new
    @employee = Employee.new
  end

  def edit
    @employee = Employee.find(params[:id])
  end

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
    @employee = Employee.find(params[:id])
    if @employee.update(employee_params)
      redirect_to employee_path(@employee), notice: 'Employee successfully updated.' and return
    else
      @errors = @employee.errors.full_messages
      render :edit
    end
  end

  private

  def employee_params
    params.require(:employee).permit(:first_name, :last_name, :start_date, :starting_salary,
                                     :direct_experience, :indirect_experience, :billable)
  end
end
