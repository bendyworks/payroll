# frozen_string_literal: true

class ChartsController < ApplicationController
  include FilterEmployees
  before_action :set_employees, only: [:home, :salaries, :experience]

  def home
    @salary_data_table = table_for_salaries
    @experience_data_table = table_for_experience
  end

  def balances
    @chart = BalanceChart.new.chart
  end

  def salaries
    @data_table = table_for_salaries
  end

  def experience
    @data_table = table_for_experience
  end

  private

  def set_employees
    @employees = filtered_collection(employee_chart_params).to_a
  end

  def table_for_salaries
    SalaryGraph.new(@employees, Salary.all_dates).to_table
  end

  def table_for_experience
    @employees.to_json(methods: [:weighted_years_experience,
                                 :current_or_last_pay,
                                 :display_name])
  end

  def employee_chart_params
    employment = params[:employment].try(:permit, :past, :current, :future)
    billable = params[:billable].try(:permit, :true, :false)
    employment = { 'current' => '1' } if employment.nil? && billable.nil?
    { employment: employment.to_h, billable: billable.to_h }
  end
end
