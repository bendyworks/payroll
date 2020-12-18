# frozen_string_literal: true

class ChartsController < ApplicationController
  include FilterEmployees
  before_action :set_employees, only: [:home, :salaries, :experience]

  def home
    @salary_data_table = create_salary_data_table @employees
    @experience_data_table = ExperienceGraph.new(@employees).to_table
  end

  def balances
    @chart = BalanceChart.new.chart
  end

  def salaries
    @data_table = create_salary_data_table(@employees)
  end

  def experience
    @data_table = ExperienceGraph.new(@employees).to_table
  end

  private

  def set_employees
    @employees = filtered_collection(employee_chart_params).to_a
  end

  def employee_chart_params
    employment = params[:employment].try(:permit, :past, :current, :future)
    billable = params[:billable].try(:permit, :true, :false)
    employment = { 'current' => '1' } if employment.nil? && billable.nil?
    { employment: employment, billable: billable }
  end

  def create_salary_data_table(employees)
    all_dates = Salary.all_dates
    all_dates.map do |date|
      # Multiply by 1000 to convert from seconds since the epoch to
      # milliseconds since the epoch
      [date.to_time.to_f * 1000] + employees.map { |e| e.salary_on(date) }
    end
  end
end
