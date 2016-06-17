module Api
  module V1
    class EmployeesController < ApiController
      def index
        render json: Employee.all
      end
    end
  end
end
