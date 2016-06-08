class PagesController < ApplicationController
  include FilterEmployees

  def home
    @employees = filtered_collection(employee_chart_params).to_a
    @all_dates = Salary.all_dates
    @data_table = @all_dates.map do |date|
      [date.to_time.to_f * 1000] + @employees.map { |e| e.salary_on(date) }
    end
    create_experience_chart
  end

  def employee_chart_params
    employment = params[:employment].try(:permit, :past, :current, :future)
    billable = params[:billable].try(:permit, :true, :false)
    employment = { 'current' => '1' } if employment.nil? && billable.nil?
    { employment: employment, billable: billable }
  end

  private

  def create_experience_chart
    @experience_chart = ExperienceChart.new(employee_chart_params,
                                            width: 300,
                                            height: 200,
                                            legend: 'none',
                                            hAxis: { textPosition: 'none' },
                                            vAxis: { textPosition: 'none' },
                                            chartArea: { width: '100%', height: '100%' }
                                           ).chart
  end
end
