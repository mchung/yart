Yet Another Rails Template
==========================

A Rails template by Marc Chung. To create a Rails project with this template:

    $ rails -m yart.rb your_awesome_rails_project
    $ cat your_awesome_rails_project/README

What is Yart?
=============

Yart encapsulates the body of Rails knowledge acquired from several hundred years of Rails development.

What does Yart do?
==================

  1. Vendors Rails into vendor/rails
  2. Uses database sessions
  3. Uses the OpenRain Power Tools for convenient deployment
  4. Vendors the following gems
    * clearance - for User authentication
    * will_paginate - for paginating data
    * formtastic - for simple to use forms
    * paperclip - for handling attachments
  5. Vendors the following gems for testing
    * factory_girl - an alternative to fixtures
    * rspec - an alternative to Test Unit
    * cucumber - acceptance testing
  6. Sets up a default "home" controller

Yart TODO list
==============

  * Bundle assets to support Rails apps running on JRuby
  * Culerity and Celerity for testing JavaScript

Thanks goes to...
=================

  * [Rails Templates][1]
  * [How to setup RSpec, Cucumber, Webrat, Rcov, and autotest][2]
  * [jeremymcanally/rails-templates][3]


  [1]: http://m.onkey.org/2008/12/4/rails-templates
  [2]: http://www.claytonlz.com/index.php/2009/04/how-to-setup-rspec-cucumber-webrat-rcov-and-autotest-on-leopard/
  [3]: http://github.com/jeremymcanally/rails-templates
