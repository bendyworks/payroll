class EmployeesController < ApplicationController

  def show
    @employee = Employee.find(params[:id])
  end

  def new
    @employee = Employee.new
  end

  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      starting_salary_params = salary_params.merge(start_date: @employee.start_date)
      @salary = @employee.salaries.new(starting_salary_params)
      if @salary.save
        redirect_to employee_path(@employee), notice: 'Employee successfully created.' and return
      end
    end
    @errors = @employee.errors.any? ? @employee.errors.full_messages : @salary.errors.full_messages
    render :new
  end

  private

  def employee_params
    params.require(:employee).permit(:first_name, :last_name, :start_date,
                                     :direct_experience, :indirect_experience, :billable)
  end

  def salary_params
    params.require(:employee).permit(:annual_amount)
  end
end
