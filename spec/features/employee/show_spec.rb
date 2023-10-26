require "rails_helper"

RSpec.describe "Employee Show Page" do
  before(:each) do
    @d_it = Department.create!(:name => "IT", floor: "Basement")
    @d_devops = Department.create!(:name => "DevOps", floor: "Basement")
    @d_mgmt = Department.create!(:name => "Management", floor: "Top")
    @departments = [@d_mgmt, @d_it, @d_devops]
    @e_tp = @d_mgmt.employees.create!(:name => "TP", level: 3)
    @e_ap = @d_mgmt.employees.create!(name: "Amanda", level: 2)
    @e_dp = @d_it.employees.create!(name: "David", level: 1)
    @e_rp = @d_devops.employees.create!(name: "Robby", level: 1)
    @t_t1 = @e_tp.tickets.create!(subject: "Fire Robby", age: 4)
    @t_t2 = @e_tp.tickets.create!(subject: "Fire David", age: 2)
  end

  it "shows name and dept. and list of all tickets from oldest to newest" do
    # As a user,
    # When I visit the Employee show page,
    # I see the employee's name, their department,
    # and a list of all of their tickets from oldest to newest.
    # I also see the oldest ticket assigned to the employee listed separately.
    visit "/employees/#{@e_tp.id}"

    expect(page).to have_content "#{@e_tp.name}"
    expect(page).to have_content "#{@e_tp.department.name}"

    expect(@t_t1.subject).to appear_before @t_t2.subject
  end

  it "also shows the oldest ticket listed separately" do
    visit "/employees/#{@e_tp.id}"

    within(".oldest-ticket") do
      expect(page).to have_content @t_t1.subject
    end
  end

  it "has a form to add a ticket and then populates on the show page" do
    # As a user,
    # When I visit the employee show page,
    # I do not see any tickets listed that are not assigned to the employee
    # and I see a form to add a ticket to this employee.
    # When I fill in the form with the id of a ticket that already exists in the database
    # and I click submit
    # Then I am redirected back to that employees show page
    # and I see the ticket's subject now listed.
    # (you do not have to test for sad path, for example if the id does not match an existing ticket.)
    visit "/employees/#{@e_tp.id}"

    ticket = Ticket.create!(subject: "Promote Amanda", age: 10)

    # require 'pry'; binding.pry
    fill_in "Ticket ID", with: ticket.id
    click_button "Add Ticket"

    # expect(page).to have_current_path "/employees/#{@e_tp.id}"

    expect(page).to have_content ticket.subject
  end

  it "shows the employees name and level" do
    # As a user,
    # When I visit an employee's show page
    # I see that employees name and level
    # and I see a unique list of all the other employees that this employee shares tickets with
    visit "/employees/#{@e_tp.id}"

    expect(page).to have_content "#{@e_tp.name}"
    expect(page).to have_content "#{@e_tp.department.name}"
    expect(page).to have_content "Lvl: #{@e_tp.level}"
  end

  it "has a best friends section that the employee shares tickets with" do
    ticket = Ticket.create!(subject: "Promote Amanda", age: 10)
    EmployeeTicket.create!(employee_id: @e_ap.id, ticket_id: ticket.id)
    EmployeeTicket.create!(employee_id: @e_tp.id, ticket_id: ticket.id)

    visit "/employees/#{@e_tp.id}"

    within(".besties") do
      expect(page).to have_content "Amanda"
    end
  end
end
