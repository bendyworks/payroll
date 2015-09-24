module FilterEmployees

  def filtered_collection params
    scope = Employee.all
    scope = filter_by_employee_choices params[:employment], scope
    scope = filter_by_billable_choice params[:billable], scope
    scope
  end

  def filter_by_employee_choices employee_choices, scope
    case employee_choices.try(:count)
    when 1
      selected = employee_choices.keys.first
      scope = scope.send(selected)
    when 2
      if employee_choices[:past]
        if employee_choices[:current]
          scope = scope.where('start_date < ?', Date.today)
        else # :future
          scope = scope.where('end_date < ? OR start_date > ?', Date.today, Date.today)
        end
      else
        scope = scope.where('end_date IS NULL OR end_date > ?', Date.today)
      end
    end

    scope
  end

  def filter_by_billable_choice billable_choice, scope
    if billable_choice.try(:count) == 1
      scope = scope.billed if billable_choice[:true]
      scope = scope.support if billable_choice[:false]
    end
    scope
  end
end
