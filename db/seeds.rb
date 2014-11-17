# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Employee.delete_all
Salary.delete_all

minnie_start_date = Date.parse('2013-5-20')
daisie_start_date = Date.parse('2013-3-10')
mickey_start_date = Date.parse('2013-1-12')
donald_start_date = Date.parse('2014-2-16')

daisie = Employee.create!(first_name: 'Daisie',
                        last_name: 'Duck',
                        start_date: daisie_start_date,
                        end_date: nil,
                        billable: true)

minnie = Employee.create!(first_name: 'Minnie',
                        last_name: 'Mouse',
                        start_date: minnie_start_date,
                        end_date: nil,
                        billable: true)

mickey = Employee.create!(first_name: 'Mickey',
                        last_name: 'Mouse',
                        start_date: mickey_start_date,
                        end_date: nil,
                        billable: true)

donald = Employee.create!(first_name: 'Donald',
                         last_name: 'Duck',
                         start_date: donald_start_date,
                         end_date: nil,
                         billable: false)

Salary.create!(employee: mickey,
              start_date: mickey_start_date,
              annual_amount: '45000.00')

Salary.create!(employee: daisie,
              start_date: daisie_start_date,
              annual_amount: '57000.00')

Salary.create!(employee: minnie,
              start_date: minnie_start_date,
              annual_amount: '46000.00')

Salary.create!(employee: daisie,
              start_date: '2013-7-1',
              annual_amount: '59000.00')

Salary.create!(employee: mickey,
              start_date: '2013-7-1',
              annual_amount: '50000.00')

Salary.create!(employee: minnie,
              start_date: '2014-1-1',
              annual_amount: '49000.00')

Salary.create!(employee: mickey,
              start_date: '2014-1-1',
              annual_amount: '55000.00')

Salary.create!(employee: donald,
              start_date: donald_start_date,
              annual_amount: '40000.00')

puts 'Seed data created.'
