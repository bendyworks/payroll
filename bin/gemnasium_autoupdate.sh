
# as per https://gemnasium.com/bendyworks/payroll/settings#auto-update
# newest commit has to already be pushed, and analyzed by gemnasium first

export GEMNASIUM_TESTSUITE="bundle exec rake"
export GEMNASIUM_PROJECT_SLUG="github.com/bendyworks/payroll"
gemnasium --token 250779aa3cc41b7cf33714dee328f2b6 autoupdate run
open https://github.com/bendyworks/payroll/pulls
