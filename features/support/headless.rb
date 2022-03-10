# Allows Cucumber tests to run as headless, in coordination with 'headless' gem
#
# @note = in order for headless to work, you must `sudo apt install xvfb`, because 'xvfb' helps run headless tests
# @ref = https://github.com/leonid-shevtsov/headless
# @ref = https://sermoa.wordpress.com/2011/07/02/cucumber-running-headless-selenium-with-jenkins-the-easy-way/
#
# To run headless cucumber tests, just pass the HEADLESS var via command line like this:
#   $ HEADLESS=true cucumber              or,
#   $ HEADLESS=true rake cucumber         or,
#   $ HEADLESS=true bundle exec cucumber
#
# Conversely, to run cucumber tests without headless (you see the browser window appear and run through each test),
# simply do not pass the HEADLESS variable beforehand
if ENV['HEADLESS'] == 'true'
	require 'headless'

	headless = Headless.new
	headless.start

	at_exit do
		headless.destroy
	end
end