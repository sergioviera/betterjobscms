source 'https://rubygems.org'
gem 'rails', '3.2.13'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

group :development, :test do
  gem 'sqlite3'
end
group :production do
#  gem 'mysql2', '~> 0.3.11'
	gem 'pg'
  gem 'sqlite3'
  gem 'execjs'
  gem 'therubyracer', :platform => :ruby
end


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.6'
  gem 'coffee-rails', '~> 3.2.2'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  #gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 2.0.1'
end

gem 'jquery-rails', '~> 2.0.0'

gem 'httparty', '~> 0.10.2'
gem 'multi_xml', '~> 0.5.3' 

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'

# Refinery CMS
gem 'refinerycms', '~> 2.0.0', :git => 'git://github.com/refinery/refinerycms.git', :branch => '2-0-stable'

# Specify additional Refinery CMS Extensions here (all optional):
gem 'refinerycms-i18n', '~> 2.0.0'
#  gem 'refinerycms-blog', '~> 2.0.0'
#  gem 'refinerycms-inquiries', '~> 2.0.0'
#  gem 'refinerycms-search', '~> 2.0.0'
#  gem 'refinerycms-page-images', '~> 2.0.0'

gem 'refinerycms-blog', '~> 2.0.0'
gem 'refinerycms-events', :path => 'vendor/extensions'


# gem 'capistrano'
gem 'rvm-capistrano'
