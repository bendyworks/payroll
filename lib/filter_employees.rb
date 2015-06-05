module FilterEmployees

  def filtered_collection params
    scope = Employee.all

    if params[:employment]
      if params[:employment].count == 1
        scope = scope.past if params[:employment][:past]
        scope = scope.current if params[:employment][:current]
        scope = scope.future if params[:employment][:future]
      elsif params[:employment].count == 2
        scope = scope.where('start_date < ?', Date.today) if params[:employment][:past] && params[:employment][:current]
        scope = scope.where('end_date < ? OR start_date > ?', Date.today, Date.today) if params[:employment][:past] && params[:employment][:future]
        scope = scope.where('end_date IS NULL OR end_date > ?', Date.today) if params[:employment][:current] && params[:employment][:future]
      end
      # if all three are selected, don't filter.
    end

    scope
  end

end
