class ChartsController < ApplicationController
  def history
    @chart = HistoryChart.new(params).chart
  end

  def experience
    @chart = ExperienceChart.new(params).chart
  end
end
