########### 
#
# rails
#
#

rake("rails:freeze:gems") # RELEASE=2.3.5
rake("db:sessions:create")

########### 
#
# plugins
#
#

plugin "power_tools", :git => "git://github.com/openrain/power_tools.git"

########### 
#
# runtime gems
#
#

gem "clearance", :version => "0.8.3", :source  => "http://gemcutter.org"
gem "will_paginate", :version => "2.3.11", :source => "http://gemcutter.org"
gem "formtastic", :version => "0.9.7", :source => "http://gemcutter.org"
gem "paperclip", :version => "2.3.1.1", :source => "http://gemcutter.org"
gem "rack", :version => "1.0.1", :source => "http://gemcutter.org"
# gem "pg", :version => "0.8.0", :source => "http://gemcutter.org"

########### 
#
# test (rspec) gems
#
#

config =<<CONFIG
config.gem "factory_girl",  :version => "1.2.3", :source => "http://gemcutter.org"
config.gem "rspec",         :lib => false, :version => "1.2.9", :source => "http://gemcutter.org"
config.gem "rspec-rails",   :lib => false, :version => "1.2.9", :source => "http://gemcutter.org"
config.gem "email_spec",   :lib => "email_spec", :version => "0.3.7", :source => "http://gemcutter.org"
CONFIG

run "echo \'
#{config}
\' >> config/environments/test.rb"

########### 
#
# postgres
#
#

pgconf = <<END
development:
  adapter: postgresql
  database: yart_development
  username: postgres
  password:
  host: localhost

test: &TEST
  adapter: postgresql
  database: yart_test
  username: postgres
  password:
  host: localhost

cucumber:
  <<: *TEST
END
run "echo '#{pgconf}' > config/database.yml.postgresql.sample"

###########
#
# generators
#
#

generate("rspec")
generate("cucumber --rspec")
generate("formtastic")
generate("clearance")
generate("clearance_views")
run("yes | script/generate clearance_features")
generate("email_spec")

########### 
#
# test (cucumber) gems
#
#

config =<<CONFIG
config.gem "factory_girl",  :version => "1.2.3", :source => "http://gemcutter.org"
config.gem "nokogiri",      :version => "1.4.0", :lib => false, :source => "http://gemcutter.org"
config.gem "email_spec",    :version => "0.3.7", :lib => "email_spec", :source => "http://gemcutter.org"
CONFIG

run "echo \'
#{config}
\' >> config/environments/cucumber.rb"

###########
#
# update env.rb
#
#

run "echo \'
require \"email_spec/cucumber\"
\' >> features/support/env.rb"

###########
#
# vendor gem everything, except native deps: nokogiri and pg
#
#

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

run "cp config/database.yml config/database.yml.sample"

file ".gitignore", <<-END
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
run "rm db/*.sqlite3"

run "touch public/stylesheets/screen.css"
run "mv test/factories spec"
run "rmdir test/fixtures test/functional test/integration test/unit"

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

# initializer "mime_types.rb",
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

###########
#
# initial files
#
#

file "app/views/home/index.html.erb",
%q{<h1>Home#index</h1>
  <p>Find me in app/views/home/index.html.erb</p>
  <ul>
    <li><%= link_to("Sign up", sign_up_path) %></li>
    <li><%= link_to("Sign in", sign_in_path) %></li>
    <li><%= link_to("Sign out", sign_out_path) %></li>
  </ul>
}

file "app/views/layouts/_flashes.html.erb",
%q{<div id="flashes">
  <% flash.each do |key, value| -%>
    <div id="flash_<%= key -%>"><%= html_escape(value) %></div>
  <% end -%>
</div>
}

file "app/helpers/application_helper.rb", 
%q{module ApplicationHelper
  def body_class
    "#{controller.controller_name} #{controller.controller_name}-#{controller.action_name}"
  end
end
}

file "app/views/layouts/application.html.erb",
%q{<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <meta http-equiv="Content-type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title><%= @page_title or "Page Title" %></title>
    <%= stylesheet_link_tag "screen", :media => "all", :cache => true %>
    <%= stylesheet_link_tag "formtastic" %>
    <%= stylesheet_link_tag "formtastic_changes" %>
    <%= javascript_include_tag :defaults, :cache => true %>
  	<link rel="shortcut icon" type="image/x-icon" href="/images/rails.png" />
  	<link rel="icon" type="image/x-icon" href="/images/rails.png" />
  </head>

  <body class="<%= body_class %>">
    <%= render :partial => "layouts/flashes" -%>
    <%= yield %>
  </body>
</html>
}

file "config/cucumber.yml",
%q{
  default: --format progress features --strict --tags ~@wip
  wip: --tags @wip:3 --wip features
}

# run "curl -L http://jqueryjs.googlecode.com/files/jquery-1.2.6.min.js > public/javascripts/jquery.js"
# run "curl -L http://jqueryjs.googlecode.com/svn/trunk/plugins/form/jquery.form.js > public/javascripts/jquery.form.js"

########### 
#
# post instructions
#
#

file "README", <<-END
To get started:

 $ rake db:create:all
 $ rake db:migrate
 $ rake db:test:clone
 # sudo gem install ZenTest autotest-rails
 $ AUTOFEATURE=true ./script/autospec
 or
 $ ./script/server
END

########### 
#
# git
#
#

git :init
git :add => "."
git :commit => "-a -m 'Initial commit'"