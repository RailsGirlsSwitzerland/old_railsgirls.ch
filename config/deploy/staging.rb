# NOTE ! NOTE SETUP YET !!!!!!!!

set :deploy_to, '/var/www/sta.railsgirls.ch'
set :user, "railsgirls"
set :branch, "dev"

role :app, 'sta.silvermind.ch'
role :web, 'sta.silvermind.ch'
role :db,  'sta.silvermind.ch', :primary => true
