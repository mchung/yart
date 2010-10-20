
class AppBuilder < Rails::AppBuilder
  include Thor::Actions
  include Thor::Shell

  # Updates the Gemfile to include useful Rubygems in development/production
  # 
  def update_environment
    @generator.append_file "Gemfile", <<-DOC
gem "formtastic", "~> 1.1.0"
gem "will_paginate", "~> 2.3.15"
# gem "capitate", "~> 0.3.6"
gem "json", "~> 1.4.6"
gem "nokogiri", "~> 1.4.3.1"
gem "friendly_id", "~> 3.1"
gem "rest-client", "~> 1.6.1", :require => "rest_client"
# gem "paperclip"
# gem "fastercsv"
# gem "clearance"
# gem "authlogic"
DOC
  end
  
  # Configures the session_store to use active_record_store. 
  # 
  def use_db_sessions
    remove_file "config/initializers/session_store.rb"
    create_file "config/initializers/session_store.rb", <<-EOF
#{app_name.camelize}::Application.config.session_store :active_record_store
EOF
    system("rake db:sessions:create")
  end
  
  # Installs and setups formtastic
  #
  def formtastic
    say("Installing formtastic from generator", :yellow)
    system("rails generate formtastic:install")
    say("TODO: Add <%= formtastic_stylesheet_link_tag %> to layout.")
  end
  
  # Updates the Gemfile to include useful Rubygems in testing
  # 
  def update_testing_environment
    @generator.append_file "Gemfile",  <<-DOC
group :test do
  gem "factory_girl_rails", "~> 1.0.0"
  gem "rspec", "~> 2.0.0"
  gem "rspec-rails", "~> 2.0.0"
  gem "cucumber", "~> 0.9.2"
  gem "cucumber-rails", "~> 0.3.2"
  gem "pickle", "~> 0.4.2"
  gem "capybara", "~> 0.4.0.rc" # Or 0.3.9
  gem "faker", "0.3.1"
  gem "database_cleaner", "~> 0.5.2"
  gem "launchy", "0.3.7"
end
    DOC
  end
  
  # Installs and setups rspec, for easily testing your code
  #
  def rspec
    say("Installing rspec from generator", :yellow)
    system("rails generate rspec:install")
  end
  
  # Installs and setups factory_girl, for easily creating models
  #
  def factory_girl
    create_file "spec/factories.rb", <<-EOF
puts "Loading FactoryGirl"
EOF
  end
  
  # Installs and setups cucumber, for humans to understand
  #
  def cucumber
    say("Installing cucumber from generator", :yellow)
    system("rails generate cucumber:install --capybara --rspec")
  end
  
  # Installs and setups pickle, for easily working with Cucumber.
  #
  def pickle
    say("Installing pickle from generator", :yellow)
    system("rails generate pickle")
  end

    # TODO: Find a nice library for testing JavaScript.
    # 
#   def jasmine
#     say("Installing jasmine from generator", :yellow)
#     #system("rails generate jasmine:install")
#   end

  # Creates a gemset for this application. 
  #
  def rvm_gemset
    say("Installing rvm gemset from templates", :yellow)
    create_file ".rvmrc", "rvm --create 1.9.2-p0@#{app_name}"
  end

  # Installs and setups newrelic, so operations can get insight into what's going on. 
  #
  # TODO: Not supported yet!
  def newrelic
    say("Installing newrelic from github.com", :yellow)
    system("git clone http://github.com/smtlaissezfaire/newrelic_rpm.git /tmp/newrelic_rpm")
    copy_file "/tmp/newrelic_rpm/newrelic.yml", "config/newrelic_rpm.yml"
  end

  def leftovers
    rvm_gemset
    
    update_environment
    update_testing_environment
    system("bundle install")

    use_db_sessions

    formtastic
    rspec
    factory_girl
    cucumber

    say("cd #{app_name} && bundle install", :yellow)
    # newrelic unless @options[:skip_newrelic]
  end
end