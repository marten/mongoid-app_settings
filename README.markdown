# mongoid-app\_settings

[![Build Status](https://secure.travis-ci.org/marten/mongoid-app_settings.png)](http://travis-ci.org/marten/mongoid-app\_settings)

This is a fairly simple gem to let you work with application configuration
that's stored in Mongoid. It's inspired by a similar project called
[rails-settings](https://github.com/ledermann/rails-settings), except this
stores it in MongoDB using Mongoid.

It's a little more explicit in that it requires you to define a list of
settings beforehand.

## Usage

Simply create some class and include `Mongoid::AppSettings`.

    class MySettings
      include Mongoid::AppSettings

      setting :enable_my_feature, default: true
      setting :something_else
    end

Then you can do things like:

    MySettings.enable_my_feature
    => true

    MySettings.enable_my_feature = false
    MySettings.enable_my_feature
    => false

    MySettings.something_else = "FooBar"
    MySettings.something_else
    => "FooBar"

You can unset a value (reverting it to the default if given):

    MySettings.delete(:enable_my_feature)
    MySettings.enable_my_feature
    => true

You can get a list of all values:

    MySettings.all
    => {:enable_my_feature => true, :something_else => "FooBar"}

You can get a list of defaults:

    MySettings.defaults
    => {:enable_my_feature => true, :something_else => nil}

Settings are cached until manually reloaded. In your ApplicationController, you
might want to do something like

    class ApplicationController < ActionController::Base
      before_filter :reload_settings

      def reload_settings
        Settings.reload
      end
    end

# Changelog

* 1.2.0 - Added chaining behaviour for reload: `AppSettings.reload.some_setting` is now possible.
* 1.1.1 - Add support for Mongoid 4 (available in git). Still supports Mongoid 2 and 3.
* 1.1 - Add support for Mongoid 3. Mongoid 2 is still supported.
* 1.0 - Feature complete and stable. Until I need more features, that is.

# Contributing to mongoid-app\_settings

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2011 Marten Veldthuis. See LICENSE.txt for further details.

