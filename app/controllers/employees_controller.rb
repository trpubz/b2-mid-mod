class EmployeesController < ApplicationController
  def show
    @employee = Employee.find(params[:id])

    @e_tix = @employee.tickets.order(age: :desc)

    bestie_ids = EmployeeTicket.where(ticket_id: @e_tix.pluck(:id)).pluck(:employee_id).uniq

    bestie_ids.delete(params[:id].to_i)

    @besties = Employee.find(bestie_ids).pluck(:name)
  end
end
