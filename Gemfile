source 'http://rubygems.org'

gem 'rails', '3.0.9'
# gem "devise"
# gem 'will_paginate', '3.0.pre2'
gem 'kaminari' # https://github.com/amatsuda/kaminari
gem 'haml-rails' # https://github.com/indirect/haml-rails
gem 'thin'
gem 'pg'
gem 'mysql2', '= 0.2.7'
gem 'jquery-rails' # https://github.com/rails/jquery-rails

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
gem 'capistrano' # https://github.com/capistrano/capistrano
gem 'aws-s3', :require => 'aws/s3'

group :development do
  gem 'rspec-rails'
  gem 'debugger' unless ENV['RM_INFO']
  gem 'debugger-linecache'
  gem 'debugger-xml'
end

group :test do
  gem 'rspec-rails'
  gem 'webrat'
end
gem 'rubber', '1.14.1' # https://github.com/wr0ngway/rubber
gem 'amazon-ec2' # https://github.com/grempe/amazon-ec2
