class ChartsController < ApplicationController
  before_action :start_date

  def balances
    @chart = BalanceChart.new.chart
  end

  def salaries
    @chart = SalaryChart.new(employee_chart_params).chart
  end

  def experience
    @chart = ExperienceChart.new(employee_chart_params).chart
  end

  private

  def start_date
    @employees = Employee.all
    @start_dates = []
    @employees.each do |employee|
      @start_dates << employee.start_date
    end
  end

  def employee_chart_params
    employment = params[:employment].try(:permit, :past, :current, :future)
    billable = params[:billable].try(:permit, :true, :false)
    employment = { 'current' => '1' } if employment.nil? && billable.nil?
    { employment: employment, billable: billable }
  end
end
