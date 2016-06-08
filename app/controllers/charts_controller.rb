class ChartsController < ApplicationController
  include FilterEmployees

  def balances
    @chart = BalanceChart.new.chart
  end

  def salaries
    @employees = filtered_collection(employee_chart_params).to_a
    @all_dates = Salary.all_dates
    @data_table = @all_dates.map do |date|
      # Multiply by 1000 to convert from seconds since the epoch to
      # milliseconds since the epoch
      [date.to_time.to_f * 1000] + @employees.map { |e| e.salary_on(date) }
    end
  end

  def experience
    @chart = ExperienceChart.new(employee_chart_params).chart
  end

  private

  def employee_chart_params
    employment = params[:employment].try(:permit, :past, :current, :future)
    billable = params[:billable].try(:permit, :true, :false)
    employment = { 'current' => '1' } if employment.nil? && billable.nil?
    { employment: employment, billable: billable }
  end
end
