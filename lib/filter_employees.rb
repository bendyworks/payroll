# frozen_string_literal: true

module FilterEmployees
  def filtered_collection(params)
    scope = Employee.all
    scope = filter_by_employee_choices params[:employment], scope
    scope = filter_by_billable_choice params[:billable], scope
    scope.order(:first_name)
  end

  private

  def filter_by_employee_choices(employee_choices, scope)
    if [1, 2].include?(employee_choices.try(:count))
      scope = scope.send employee_choices.keys.join('_or_')
    end
    scope
  end

  def filter_by_billable_choice(billable_choice, scope)
    if billable_choice.try(:count) == 1
      scope = scope.billed if billable_choice[:true]
      scope = scope.support if billable_choice[:false]
    end
    scope
  end
end
