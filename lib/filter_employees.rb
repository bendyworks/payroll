module FilterEmployees

  def filtered_collection(params)
    show_inactive = (params[:show_inactive] == 'true')

    show_inactive ? Employee.all : Employee.current
  end
end
