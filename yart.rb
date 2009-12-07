########### 
#
# rails
#
#

rake("rails:freeze:gems") # RELEASE=2.3.5
rake('db:sessions:create')

########### 
#
# plugins
#
#

plugin 'power_tools', :git => 'git://github.com/openrain/power_tools.git'

########### 
#
# runtime gems
#
#

gem "clearance", :version => '0.8.3', :source  => 'http://gemcutter.org'
gem 'will_paginate', :version => '2.3.11', :source => 'http://gemcutter.org'
gem 'formtastic', :version => '0.9.7', :source => 'http://gemcutter.org'
gem 'paperclip', :version => '2.3.1.1', :source => 'http://gemcutter.org'
gem 'rack', :version => '1.0.1', :source => 'http://gemcutter.org'

########### 
#
# test (rspec) gems
#
#

config =<<CONFIG
config.gem "factory_girl",  :version => "1.2.3", :source => "http://gemcutter.org"
config.gem "rspec",         :lib => false, :version => "1.2.9", :source => "http://gemcutter.org"
config.gem "rspec-rails",   :lib => false, :version => "1.2.9", :source => "http://gemcutter.org"
CONFIG

run "echo \'
#{config}
\' >> config/environments/test.rb"

########### 
#
# generators
#
#

generate("rspec")
generate("cucumber")
generate("formtastic")
generate("clearance")
generate("clearance_views")
run("yes | script/generate clearance_features")

########### 
#
# test (cucumber) gems
#
#

# webrat
# cucumber + deps
# nokogiri - it's a native gem

config =<<CONFIG
config.gem "factory_girl",  :version => "1.2.3", :source => "http://gemcutter.org"
config.gem "nokogiri",      :version => "1.4.0", :lib => false, :source => "http://gemcutter.org"
CONFIG

run "echo \'
#{config}
\' >> config/environments/cucumber.rb"

rake "gems:install"
rake "gems:unpack"
run "rake gems:unpack RAILS_ENV=test"
run "rake gems:unpack:dependencies RAILS_ENV=test"
run "rake gems:unpack RAILS_ENV=cucumber"
run "rake gems:build RAILS_ENV=cucumber"
run "rake gems:unpack:dependencies RAILS_ENV=cucumber"
run "rm -rf vendor/gems/nokogiri-1.4.0"

########### 
#
# commands
#
#

run "cp config/database.yml config/database.yml.example"

file '.gitignore', <<-END
.DS_Store
coverage/*
log/*.log
tmp/**/*
config/database.yml
db/*.sqlite3
db/*.db
END

run "rm public/index.html"
run "rm public/favicon.ico"
run "rmdir test/fixtures test/functional test/integration test/unit"
run "mv test/factories spec"

run 'echo "
DO_NOT_REPLY = \'noreply@tasteredpear.com\'" >> config/environment.rb'

run 'echo "
HOST = \'localhost\'" >> config/environments/test.rb'

run 'echo "
HOST = \'localhost\'" >> config/environments/development.rb'

run 'echo "
HOST = \'client.tasteredpear.com\'" >> config/environments/production.rb'

run 'echo "
HOST = \'localhost\'" >> config/environments/cucumber.rb'

########### 
#
# initializers
#
#

# initializer 'mime_types.rb',
# %q{
# Mime::Type.register_alias "application/json", :json
# }

########### 
#
# default controller
#
#

generate("rspec_controller Home index")
route("map.root :controller => :home")

file 'app/views/layouts/_flashes.html.erb',
%q{<div id="flashes">
  <% flash.each do |key, value| -%>
    <div id="flash_<%= key -%>"><%= html_escape(value) %></div>
  <% end -%>
</div>
}

file 'app/helpers/application_helper.rb', 
%q{module ApplicationHelper
  def body_class
    "#{controller.controller_name} #{controller.controller_name}-#{controller.action_name}"
  end
end
}

file 'app/views/layouts/application.html.erb',
%q{<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <meta http-equiv="Content-type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title><%= @page_title or 'Page Title' %></title>
    <%= stylesheet_link_tag 'screen', :media => 'all', :cache => true %>
    <%= javascript_include_tag :defaults, :cache => true %>
  </head>

  <body class="<%= body_class %>">
    <%= render :partial => 'layouts/flashes' -%>
    <%= yield %>
  </body>
</html>
}


 # 36.run "curl -L http://jqueryjs.googlecode.com/files/jquery-1.2.6.min.js > public/javascripts/jquery.js"
 # 37.run "curl -L http://jqueryjs.googlecode.com/svn/trunk/plugins/form/jquery.form.js > public/javascripts/jquery.form.js"
 # 38.

########### 
#
# post instructions
#
#

file 'README', <<-END
To get started:

 $ rake db:create:all
 $ rake db:migrate
 # rake db:test:clone
 $ AUTOFEATURE=true script/autospec
END

########### 
#
# git
#
#

git :init
git :add => "."
git :commit => "-a -m 'Initial commit'"
