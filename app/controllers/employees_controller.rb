class EmployeesController < ApplicationController

  def show
    @employee = Employee.find(params[:id])
    opts = { width: 640, height: 400, legend: 'none',
             vAxis: { title: 'Salary Rate ($ annually)', minValue: 0 } }
    @chart = GoogleVisualr::Interactive::LineChart.new(employee_salary_history_data, opts)
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
      redirect_to employee_path(@employee), notice: 'Employee successfully updated.'
    else
      @errors = @employee.errors.full_messages
      render :edit
    end
  end

  private

  def employee_params
    params.require(:employee).permit(:first_name, :last_name,
      :start_date, :end_date, :starting_salary, :direct_experience,
      :indirect_experience, :billable)
  end

  def employee_salary_history_data
    GoogleVisualr::DataTable.new cols: [{type: 'date', label: 'Date'},
                                        {type: 'number', label: @employee.first_name}],
                                 rows: @employee.salary_data
  end
end
