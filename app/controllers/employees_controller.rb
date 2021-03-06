class EmployeesController < ApplicationController
    before_action :find_employee, only: [:show, :edit, :update]
    before_action :employee_authorized, only: [:show]
    
    def show
    end

    def new   
        @employee = Employee.new
    end
    
    def create
        @employee = Employee.new(employee_params)
        if @employee.valid?
            @employee.save
            if current_manager
                redirect_to manager_path(current_manager)
            else
                flash[:success] = "Employee was successfully created!"
                redirect_to login_path
            end
        else
            flash[:errors] = @employee.errors.full_messages
            redirect_to new_employee_path
        end
    end

    def edit
    end 

    def update
        if employee_authorized
            @employee.update(employee_params)
            flash[:success] = 'Employee Profile has successfully been updated!'
            redirect_to employee_path(@employee)
        end
    end

    private

    def employee_params
        params.require(:employee).permit(:first_name, :last_name, :username, :email, :password, :years_working)
    end
    
    def find_employee
        @employee = Employee.find(params[:id])
    end

end
