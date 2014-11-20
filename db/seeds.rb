# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Employee.delete_all
Salary.delete_all

###### FORMER EMPLOYEES ######

darkwing_start_date = Date.parse('2012-11-11')
darkwing_end_date = Date.parse('2014-1-1')
darkwing = Employee.create!(first_name: 'Darkwing', last_name: 'Duck',
                            start_date: darkwing_start_date, end_date: darkwing_end_date)
Salary.create!(employee: darkwing, start_date: darkwing_start_date,      annual_amount: '100000')
Salary.create!(employee: darkwing, start_date: darkwing_start_date + 90, annual_amount: '200000')

###### CURRENT EMPLOYEES #######
## Daisie
daisie_start_date = Date.parse('2013-1-1')
daisie = Employee.create!(first_name: 'Daisie', last_name: 'Duck',
                          direct_experience: 6, indirect_experience: 4,
                          start_date: daisie_start_date)
Salary.create!(employee: daisie, start_date: daisie_start_date,      annual_amount: '57000.00') #1-1-2013
Salary.create!(employee: daisie, start_date: daisie_start_date + 90, annual_amount: '59000.00') #4-1-2013

## Minnie
minnie_start_date = daisie_start_date + 90
minnie = Employee.create!(first_name: 'Minnie', last_name: 'Mouse',
                          start_date: minnie_start_date)
Salary.create!(employee: minnie, start_date: minnie_start_date,      annual_amount: '46000.00') #4-1-2013
Salary.create!(employee: minnie, start_date: minnie_start_date + 90, annual_amount: '49000.00') #6-30-2013

## Mickey
mickey_start_date = daisie_start_date + 180
mickey = Employee.create!(first_name: 'Mickey', last_name: 'Mouse',
                          indirect_experience: 18,
                          start_date: mickey_start_date)
Salary.create!(employee: mickey, start_date: mickey_start_date,      annual_amount: '45000.00') #6-30-2013
Salary.create!(employee: mickey, start_date: mickey_start_date + 40, annual_amount: '50000.00') #8-9-2013
Salary.create!(employee: mickey, start_date: mickey_start_date + 80, annual_amount: '55000.00') #9-18-2013

## Donald
donald_start_date = daisie_start_date + 270
donald = Employee.create!(first_name: 'Donald', last_name: 'Duck',
                          direct_experience: 9,
                          start_date: donald_start_date)
Salary.create!(employee: donald, start_date: donald_start_date, annual_amount: '40000.00')      #9-28-2013

#########################
puts 'Seed data created.'
