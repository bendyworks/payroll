# frozen_string_literal: true
class PlanningController < ApplicationController
  def index
    @employees = Employee.all
  end
end
