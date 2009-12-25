Yet Another Rails Template
==========================

A Rails template by Marc Chung. To create a Rails project with this template:

    $ rails -m yart.rb your_awesome_rails_project
    $ cat your_awesome_rails_project/README

    Follow the instructions.

What is Yart?
=============

Yart encapsulates the body of Rails knowledge acquired from several hundred years of Rails development.

What does Yart do?
==================

  1. Vendors Rails into vendor/rails
  2. Uses database sessions
  3. Uses the OpenRain Power Tools for convenient deployment
  4. Vendors the following gems
    * clearance - for authentication
    * will_paginate - for pagination
    * formtastic - for forms
    * paperclip - for attachments
  5. Vendors the following gems for testing
    * factory_girl - for faking data
    * rspec - for BDD and mocking
    * cucumber - for happy customers
    * email_spec - for testing emails
  6. Sets up a default "home" controller
  7. Uses PostgreSQL (heroku friendly out of the box)

Yart TODO list
==============

  * Bundle assets to support Rails apps running on JRuby
  * Culerity and Celerity for testing JavaScript

Thanks goes to...
=================

  * [Rails Templates][1]
  * [How to setup RSpec, Cucumber, Webrat, Rcov, and autotest][2]
  * [jeremymcanally/rails-templates][3]


Known Issues
============

If this is the first time running this template, you need to use `sudo` so that the
gems are installed into your system's directory instead of `~/.gem`.

    sudo rails -m yart.rb foo # installs gems
    rm -rf foo                # permissions are screwed up
    rails -m yart.rb foo      # good to go


  [1]: http://m.onkey.org/2008/12/4/rails-templates
  [2]: http://www.claytonlz.com/index.php/2009/04/how-to-setup-rspec-cucumber-webrat-rcov-and-autotest-on-leopard/
  [3]: http://github.com/jeremymcanally/rails-templates
