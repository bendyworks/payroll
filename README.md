payroll
=======

[![CI Status](https://github.com/bendyworks/payroll/actions/workflows/ci.yml/badge.svg?branch=main)] [![Code Climate](https://codeclimate.com/github/bendyworks/payroll/badges/gpa.svg)](https://codeclimate.com/github/bendyworks/payroll) [![Dependency Status](https://gemnasium.com/bendyworks/payroll.svg)](https://gemnasium.com/bendyworks/payroll)

Simple internal application to visualize payroll and inform salary decisions at Bendyworks.  Please feel encouraged to fork this and use for your company's needs as well. Pull requests encouraged!

We're using [google_visualr gem](https://github.com/winston/google_visualr) for graphing. [Documentation](http://googlevisualr.herokuapp.com/)

To get this up and running:
  1. clone it
  1. Make sure rvm, yarn, and the correct ruby are installed
  1. `bundle install`
  1. `rake db:setup`
  1. `yarn install`
  1. `./bin/webpack-dev-server`
  1. `rails s`
  1. visit localhost:3000

To run the tests:
  1. `rake`

To deploy:
  1. once: `git remote add heroku https://git.heroku.com/bendyworks-payroll.git`
  1. `bin/deploy.sh`

To create a new user:
  1. From the project directory, start the console with `rails c`.
  1. `User.create(email: 'your@email.com', password: 'yourpassword')`

To change your password in the console:
  1. From the project directory, start the console with `rails c`.
  1. `u = User.find_by_email('your@email.com')`
  1. `u.update password: 'newpassword'`

Using React Components
  1. React components live inside app/javascript/components
  1. Components can be rendered inside the views with:
  ~~~
    = react_component("ComponentName", props: {})
    = react_component("ComponentName", props: {}, {prerender: true})
  ~~~


Let's use page specific JavaScript, which means that you need to
remember these main ideas:
  1. Don't `// require_tree .` in the `application.js` manifest.
     JavaScript assets still live in the `app/assets/javascripts/`
     directory.
  1. Add new JavaScript assets to `config/intializers/assets.rb`'s
     `Rails.application.config.assets.precompile` list.
  1. Include the JavaScript in the specific view where it is required
     by using a `javascript_include_tag`.
