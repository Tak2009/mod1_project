# Written by and for Flatiron School

#!/usr/bin/env bash
echo "Creating $1 ActiveRecord project"

function title {
  echo $1 | gsed 's/.*/\L&/; s/[a-z]*/\u&/g'
}

mkdir $1 && cd $1
mkdir -p {db,config,app/models}
touch config/database.yml config/environment.rb Rakefile Gemfile

for i in "${@:2}"; do
    echo Creating $i.rb model
    touch app/models/$i.rb
    model=$(title $i)
    echo "class $model < ActiveRecord::Base
end
    " > app/models/$i.rb
done

echo "
source 'https://rubygems.org'

gem 'activerecord'
gem 'sinatra-activerecord'
gem 'rake'
gem 'require_all'
gem 'sqlite3'
gem 'pry'
" > Gemfile

echo "default: &default
  adapter: sqlite3
  encoding: unicode
  pool: 5

development:
  <<: *default
  database: 'db/development.sqlite'
" > config/database.yml

echo "require 'bundler/setup'
Bundler.require

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'db/development.sqlite'
)

ActiveRecord::Base.logger = Logger.new(STDOUT)

require_all 'app'
" > config/environment.rb

echo "require_relative './config/environment'
require 'sinatra/activerecord/rake'

desc 'Start our app console'
task :console do
    Pry.start
end
" > Rakefile

bundle

echo "Done creating project!"
echo "
Next steps:
- go to your project: cd $1
- check your options: rake -T
- run your project's console: rake console
"
