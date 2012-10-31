set :deploy_to, '/var/www/railsgirls.ch'
set :user, "railsgirls"
set :branch, "master"

role :app, 'live.silvermind.ch'
role :web, 'live.silvermind.ch'
role :db,  'live.silvermind.ch', :primary => true
