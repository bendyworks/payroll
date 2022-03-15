# frozen_string_literal: true

AccountType.seed

Salary.delete_all
Employee.delete_all

User.destroy_all

admin = User.create!(email: 'admin@bendyworks.com',
                     password: 'password',
                     admin: true,
                     invitation_accepted_at: Time.zone.now)
User.create!(email: 'user@bendyworks.com',
                     password: 'password',
                     admin: false,
                     invitation_accepted_at: Time.zone.now)

Balance.destroy_all
Account.destroy_all
Account.create!([
                  { name: 'City Bank Checking' },
                  { name: 'City Bank Savings' },
                  { name: 'A/R' },
                  { name: 'A/P' },
                  { name: 'WIP' },
                  { name: 'Prepaid' },
                  { name: 'SBA Loan' }
                ])

###### FORMER EMPLOYEES ######

darkwing_start_date = Date.parse('2012-11-11')
darkwing_end_date = Date.parse('2014-1-1')
darkwing = Employee.create!(first_name: 'Darkwing (gone)', last_name: 'Duck',
                            starting_salary: '100000',
                            tenures: [Tenure.new(start_date: darkwing_start_date,
                                                 end_date: darkwing_end_date)])
Salary.create!(employee: darkwing, start_date: darkwing_start_date + 90, annual_amount: '200000')

###### FUTURE EMPLOYEES ######

daffy_start_date = Time.zone.today + 10
_daffy = Employee.create!(first_name: 'Daffy (future)',
                          last_name: 'Duck',
                          starting_salary: '51000.00',
                          direct_experience: 2,
                          indirect_experience: 8,
                          tenures: [Tenure.new(start_date: daffy_start_date)])

###### CURRENT EMPLOYEES #######
## Daisie
daisie_start_date = Date.parse('2013-1-1')
daisie = Employee.create!(first_name: 'Daisie',
                          last_name: 'Duck',
                          starting_salary: '57000.00',
                          direct_experience: 6,
                          indirect_experience: 4,
                          tenures: [Tenure.new(start_date: daisie_start_date)])

Salary.create!(employee: daisie,
               start_date: daisie_start_date + 90, # 4-1-2013
               annual_amount: '59000.00')

## Minnie
minnie_start_date = daisie_start_date + 90
minnie = Employee.create!(first_name: 'Minnie', last_name: 'Mouse',
                          starting_salary: '46000.00',
                          tenures: [Tenure.new(start_date: minnie_start_date)])
Salary.create!(employee: minnie,
               start_date: minnie_start_date + 90, # 6-30-2013
               annual_amount: '49000.00')

## Mickey
mickey_start_date = daisie_start_date + 180
mickey = Employee.create!(first_name: 'Mickey', last_name: 'Mouse',
                          starting_salary: '45000.00',
                          indirect_experience: 18,
                          tenures: [Tenure.new(start_date: mickey_start_date)])

Salary.create!(employee: mickey,
               start_date: mickey_start_date + 40, # 8-9-2013
               annual_amount: '50000.00')

Salary.create!(employee: mickey,
               start_date: mickey_start_date + 80, # 9-18-2013
               annual_amount: '55000.00')

## Donald
donald_start_date = daisie_start_date + 270
_donald = Employee.create!(first_name: 'Donald (support)',
                           last_name: 'Duck',
                           starting_salary: '40000.00',
                           direct_experience: 9,
                           billable: false,
                           tenures: [Tenure.new(start_date: donald_start_date)])

#########################
puts 'Seed data created.'
