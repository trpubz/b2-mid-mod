class EmployeeTicketsController < ApplicationController
  def create
    EmployeeTicket.create!(employee_id: params[:id], ticket_id: params[:ticket_id])

    redirect_to "/employees/#{params[:id]}"
  end
end