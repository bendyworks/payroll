# frozen_string_literal: true

class PlanningController < ApplicationController
  def index
    @employees = Employee.current
  end
end
