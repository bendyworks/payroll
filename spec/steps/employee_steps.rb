step "employee" do
  @employee ||= create :employee
end

step "employees" do
  create_list :employee, 5
end
