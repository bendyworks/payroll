
AccountType.seed

Salary.delete_all
Employee.delete_all

User.delete_all
User.create!(email: 'admin@bendyworks.com', password: 'password', invitation_accepted_at: Time.now)

###### FORMER EMPLOYEES ######

darkwing_start_date = Date.parse('2012-11-11')
darkwing_end_date = Date.parse('2014-1-1')
darkwing = Employee.create!(first_name: 'Darkwing (gone)', last_name: 'Duck',
                            starting_salary: '100000',
                            start_date: darkwing_start_date, end_date: darkwing_end_date)
Salary.create!(employee: darkwing, start_date: darkwing_start_date + 90, annual_amount: '200000')

###### FUTURE EMPLOYEES ######

daffy_start_date = Date.today + 10
daffy = Employee.create!(first_name: 'Daffy (future)', last_name: 'Duck',
                         starting_salary: '51000.00',
                         direct_experience: 2, indirect_experience: 8,
                         start_date: daffy_start_date)

###### CURRENT EMPLOYEES #######
## Daisie
daisie_start_date = Date.parse('2013-1-1')
daisie = Employee.create!(first_name: 'Daisie', last_name: 'Duck',
                          starting_salary: '57000.00',
                          direct_experience: 6, indirect_experience: 4,
                          start_date: daisie_start_date)
Salary.create!(employee: daisie, start_date: daisie_start_date + 90, annual_amount: '59000.00') #4-1-2013

## Minnie
minnie_start_date = daisie_start_date + 90
minnie = Employee.create!(first_name: 'Minnie', last_name: 'Mouse',
                          starting_salary: '46000.00',
                          start_date: minnie_start_date)
Salary.create!(employee: minnie, start_date: minnie_start_date + 90, annual_amount: '49000.00') #6-30-2013

## Mickey
mickey_start_date = daisie_start_date + 180
mickey = Employee.create!(first_name: 'Mickey', last_name: 'Mouse',
                          starting_salary: '45000.00',
                          indirect_experience: 18,
                          start_date: mickey_start_date)
Salary.create!(employee: mickey, start_date: mickey_start_date + 40, annual_amount: '50000.00') #8-9-2013
Salary.create!(employee: mickey, start_date: mickey_start_date + 80, annual_amount: '55000.00') #9-18-2013

## Donald
donald_start_date = daisie_start_date + 270
donald = Employee.create!(first_name: 'Donald (support)', last_name: 'Duck',
                          starting_salary: '40000.00',
                          direct_experience: 9,
                          billable: false,
                          start_date: donald_start_date)

#########################
puts 'Seed data created.'
