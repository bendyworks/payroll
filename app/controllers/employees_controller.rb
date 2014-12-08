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
    params.require(:employee).permit(:first_name, :last_name, :start_date, :starting_salary,
                                     :direct_experience, :indirect_experience, :billable)
  end

  def employee_salary_history_data
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('date', 'Date')
    data_table.new_column('number', @employee.first_name)

    data_table.add_rows( [ [@employee.start_date, @employee.starting_salary] ] )

    @employee.salaries.each_with_index do |salary, index|
      data_table.add_rows( [ [salary.start_date - 1, @employee.salary_on(salary.start_date - 1)],
                             [salary.start_date, salary.annual_amount] ] )
    end

    if @employee.end_date
      data_table.add_rows( [ [@employee.end_date, @employee.ending_salary] ] )
    elsif @employee.employed_on?(Date.today)
      data_table.add_rows( [ [Date.today, @employee.salary_on(Date.today)] ] )
    end

    data_table
  end
end
