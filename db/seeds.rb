# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
@d_mgmt = Department.create!(:name => "Management", floor: "Top")
@d_it = Department.create!(:name => "IT", floor: "Basement")
@d_devops = Department.create!(:name => "DevOps", floor: "Basement")
@departments = [@d_mgmt, @d_it, @d_devops]
@e_tp = @d_mgmt.employees.create!(:name => "TP", level: 3)
@e_ap = @d_mgmt.employees.create!(name: "Amanda", level: 2)
@e_dp = @d_it.employees.create!(name: "David", level: 1)
@e_rp = @d_devops.employees.create!(name: "Robby", level: 1)
@t_t1 = @e_tp.tickets.create!(subject: "Fire Robby", age: 4)
@t_t2 = @e_tp.tickets.create!(subject: "Fire David", age: 2)
ticket = Ticket.create!(subject: "Promote Amanda", age: 10)
ticket_robby = Ticket.create!(subject: "Don't Fire Robby", age: 1)
EmployeeTicket.create!(employee_id: @e_ap.id, ticket_id: ticket_robby.id)
EmployeeTicket.create!(employee_id: @e_tp.id, ticket_id: ticket_robby.id)
