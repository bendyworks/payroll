class ChartsController < ApplicationController
  def history
    @chart = HistoryChart.new(chart_params).chart
  end

  def experience
    @chart = ExperienceChart.new(chart_params).chart
  end

  private

  def chart_params
    employment = params[:employment].try(:permit, :past, :current, :future)
    billable = params[:billable].try(:permit, :true, :false)
    owner = params[:owner].try(:permit, :true, :false)
    {employment: employment, billable: billable, owner: owner}
  end
end
