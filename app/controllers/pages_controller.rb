class PagesController < ApplicationController
  def home
    create_salary_chart
    create_experience_chart
  end

  def employee_chart_params
    employment = params[:employment].try(:permit, :past, :current, :future)
    billable = params[:billable].try(:permit, :true, :false)
    employment = { 'current' => '1' } if employment.nil? && billable.nil?
    { employment: employment, billable: billable }
  end

  private

  def create_salary_chart
    @salary_chart = SalaryChart.new(employee_chart_params,
                                    width: 300,
                                    height: 200,
                                    legend: 'none',
                                    hAxis: { textPosition: 'none' },
                                    vAxis: { textPosition: 'none' },
                                    chartArea: { width: '100%', height: '100%' }
                                   ).chart
    # Event listener for when you select a data point on the chart...
    # @salary_chart.add_listener("select", "function() { alert('chart') }")

    # Event listener for when the chart is ready...
    # @salary_chart.add_listener("ready", "function() { alert('ready') }")
  end

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
