require "rails_helper"

RSpec.describe "Dept. Index Page" do
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

  it "shows each dept. name and floor, and underneath the employees" do
    # As a user,
    # When I visit the Department index page,
    # I see each department's name and floor
    # And underneath each department, I can see the names of all of its employees
    visit "/departments"

    @departments.each do |dept|
      within("#dept-#{dept.id}") do
        expect(page).to have_content "#{dept.name} => #{dept.floor}"
        dept.employees.all.each do |e|
          expect(page).to have_content "#{e.name}"
        end
      end
    end
  end
end