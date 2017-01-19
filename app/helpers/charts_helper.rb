# frozen_string_literal: true
module ChartsHelper
  def current_employment_checked
    (params[:employment].nil? && params[:billable].nil?) || params[:employment].try(:[], :current)
  end

  def future_employee_exists?
    Employee.exists?(['start_date > ?', Date.today])
  end
end
