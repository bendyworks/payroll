class PlanningController < ApplicationController
  def index
    @employees = Employee.all
  end
end
