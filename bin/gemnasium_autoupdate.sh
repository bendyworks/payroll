
# as per https://gemnasium.com/bendyworks/payroll/settings#auto-update

export GEMNASIUM_TESTSUITE="bundle exec rake"
export GEMNASIUM_PROJECT_SLUG="bendyworks/payroll"
gemnasium --token 250779aa3cc41b7cf33714dee328f2b6 autoupdate run
