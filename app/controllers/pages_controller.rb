# frozen_string_literal: true
class PagesController < ApplicationController
  include FilterEmployees

  def home
    @employees = filtered_collection(employee_chart_params).to_a
    @salary_data_table = create_salary_data_table @employees
    @experience_data_table = create_experience_data_table @employees
  end

  private

  def employee_chart_params
    employment = params[:employment].try(:permit, :past, :current, :future)
    billable = params[:billable].try(:permit, :true, :false)
    employment = { 'current' => '1' } if employment.nil? && billable.nil?
    { employment: employment, billable: billable }
  end

  def create_experience_data_table(employees)
    employees.map.with_index do |e, i|
      row = Array.new((@employees.length * 2) + 1)
      row[0] = e.weighted_years_experience
      row[(2 * i) + 1] = e.current_or_last_pay
      row[(2 * i) + 2] = e.experience_tooltip
      row
    end
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
