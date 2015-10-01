module ChartsHelper
  def current_employment_checked
    (params[:employment].nil? && params[:billable].nil?) || params[:employment].try(:[], :current)
  end
end
