[![Code Climate](https://codeclimate.com/github/bendyworks/payroll/badges/gpa.svg)](https://codeclimate.com/github/bendyworks/payroll)

Simple internal application to visualize payroll and inform salary decisions at Bendyworks.  Please feel encouraged to fork this and use for your company's needs as well. Pull requests encouraged!

We're using 'google_visualr' gem for graphing.

To get this up and running:
  1. clone it
  1. Make sure rvm and the correct ruby are installed
  1. `bundle install`
  1. `rake db:setup`
  1. `rails s`
  1. visit localhost:3000

To run the tests:
  1. `rake`

To create a new user:
  1. From the project directory, start the console with `rails c`.
  1. `User.create(email: 'your@email.com', password: 'yourpassword')`

To change your password in the console:
  1. From the project directory, start the console with `rails c`.
  1. `u = User.find_by_email('your@email.com')`
  1. `u.password = 'newpassword'`
  1. `u.save`
