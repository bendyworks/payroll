class ChartsController < ApplicationController
  def history
    show_inactive = (params[:show_inactive] == 'true')
    @chart = HistoryChart.new(show_inactive).chart
  end

  def experience
    show_inactive = (params[:show_inactive] == 'true')
    @chart = ExperienceChart.new(show_inactive).chart
  end
end
