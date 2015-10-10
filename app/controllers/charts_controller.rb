class ChartsController < ApplicationController
  def salaries
    @chart = SalaryChart.new(chart_params).chart
  end

  def experience
    @chart = ExperienceChart.new(chart_params).chart
  end

  private

  def chart_params
    employment = params[:employment].try(:permit, :past, :current, :future)
    billable = params[:billable].try(:permit, :true, :false)
    employment = {"current"=>"1"} if (employment.nil? && billable.nil?)
    {employment: employment, billable: billable}
  end
end
