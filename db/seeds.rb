# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Employee.delete_all
Salary.delete_all

micky_start_date = Date.parse('2013-1-12')
donald_start_date = Date.parse('2014-2-16')

micky = Employee.create!(first_name: 'Mickey',
                        last_name: 'Mouse',
                        start_date: micky_start_date,
                        end_date: nil,
                        billable: true)

donald = Employee.create!(first_name: 'Donald',
                         last_name: 'Duck',
                         start_date: donald_start_date,
                         end_date: nil,
                         billable: false)

Salary.create!(employee: micky,
              start_date: micky_start_date,
              end_date: '2013-6-30',
              annual_amount: '45000.00')

Salary.create!(employee: micky,
              start_date: '2013-7-1',
              end_date: '2013-12-31',
              annual_amount: '50000.00')

Salary.create!(employee: micky,
              start_date: '2014-1-1',
              end_date: nil,
              annual_amount: '55000.00')

Salary.create!(employee: donald,
              start_date: donald_start_date,
              end_date: nil,
              annual_amount: '40000.00')

puts 'Seed data created.'
