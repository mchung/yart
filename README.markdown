YART is Yet Another Rails Template (and Builder)
================================================

A Rails builder by Marc Chung. To create a Rails project with this builder:

    $ rails new rails_example --builder=http://github.com/mchung/yart/raw/master/recipes/fast_builder.rb --database=postgresql 

What is Yart?
============

Yart encapsulates the body of Rails knowledge acquired from several hundred years of Rails development.

I like recipes, if I have to do something more than once, it's getting automated and going in a cookbook, like creating a Ruby on Rails stack.

Let's be honest, getting started with Rails 3 is complicated. Not hard, or non-trivial, but complicated.  Where Rails' predecessors praised conventions, Rails 3 gives you choices. And with those choices come hard decisions which you don't need to be making.

So who are you?

There's a good chance you're here because someone told you about my collection of Rails 3 builder recipes. You want to get up and running in Rails in as little time as possible. You're also willing to 

YART, or Yet Another Rails Template started out as a single Rails template intended on creating a default stack for development and production.  Since it's release, I've moved it over to Rails 3, adopted Bundler, and have decided to grow my collection.

What does Yart do?
==================

  1. Uses Bundler to manage your dependencies
  2. Uses database sessions
  3. Uses Heroku for hosting your application
  4. Vendors the following gems
    * formtastic - for forms
    * will_paginate - for pagination
  5. Vendors the following gems for testing
    * factory_girl - for replacing fixtures
    * rspec - for BDD and mocking
    * cucumber and cucumber_rails/pickle - for happy customers
    * email_spec - for testing emails
  6. Uses PostgreSQL (Heroku friendly out of the box)

Thanks goes to...
=================

  * [Rails Templates][1]
  * [How to setup RSpec, Cucumber, Webrat, Rcov, and autotest][2]
  * [jeremymcanally/rails-templates][3]
  * [Rails 3 Application Builders][4]
  * [Rails::Generators::AppGenerator][5]


The Recipes
===========

[yart_builder][6] was the very first recipe. It ships with the following gems:

  1. [formtastic][7], for creating and styling forms easily.
  2. [will_paginate][8], for pagination large collections of data.

[fast_builder][9] is aimed at getting your Rails environment up and running with oauth (for authentication with Twitter or Facebook) and Heroku (for hosting your new Ruby application).  It ships with the following gems:

  1. [omnisocial][10], for oauth with Twitter and Facebook.
  2. [heroku][11], for hosting your app on Heroku.

TODO
==== 
What's in the future? Ideally yart could make your life easier by turning into a Rubygem which you could run from the command line. Until then, you'll have to create recipes manually.


  [1]: http://m.onkey.org/2008/12/4/rails-templates
  [2]: http://www.claytonlz.com/index.php/2009/04/how-to-setup-rspec-cucumber-webrat-rcov-and-autotest-on-leopard/
  [3]: http://github.com/jeremymcanally/rails-templates
  [4]: http://pivotallabs.com/users/mbarinek/blog/articles/1437-rails-3-application-builders
  [5]: http://github.com/rails/rails/blob/master/railties/lib/rails/generators/rails/app/app_generator.rb
  [6]: http://github.com/mchung/yart/blob/master/recipes/yart_builder.rb
  [7]: http://github.com/justinfrench/formtastic
  [8]: http://github.com/mislav/will_paginate
  [9]: http://github.com/mchung/yart/blob/master/recipes/fast_builder.rb
  [10]: http://github.com/icelab/omnisocial
  [11]: http://heroku.com
