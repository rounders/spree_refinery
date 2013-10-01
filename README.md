SpreeRefinery
=============

This Spree extension allows RefineryCMS 2.1 to be added to a Spree 2.0 project.

Installation
------------

Add spree_refinery to your Gemfile:

```ruby
gem 'spree_refinery'
```

RefineryCMS 2.1 currently requires jquery-rails 2.3 while Spree 2.0 requires jquery-rails ~> 3.0.0 so to get around
this problem you'll need to add the following refinerycms 2.1 branch to your Gemfile:

```ruby
gem 'refinerycms', github: 'rounders/refinerycms', branch: '2-1-stable-spree-compatible'
```


Bundle your dependencies and run the installation generator:

```shell
bundle
bundle exec rails g spree_refinery:install
```

Testing
-------

Be sure to bundle your dependencies and then create a dummy test app for the specs to run against.

```shell
bundle
bundle exec rake test_app
bundle exec rspec spec
```

When testing your applications integration with this extension you may use it's factories.
Simply add this require statement to your spec_helper:

```ruby
require 'spree_refinery/factories'
```

Copyright (c) 2013 [name of extension creator], released under the New BSD License
