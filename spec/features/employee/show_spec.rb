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
  end

  it "shows name and dept. and list of all tickets from oldest to newest" do
    # As a user,
    # When I visit the Employee show page,
    # I see the employee's name, their department,
    # and a list of all of their tickets from oldest to newest.
    # I also see the oldest ticket assigned to the employee listed separately.
  end

  it "also shows the oldest ticket listed separately" do

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
  end
end
