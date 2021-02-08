
git push heroku main:master
heroku run rake db:migrate
heroku restart
