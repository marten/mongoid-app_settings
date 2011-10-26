# mongoid-app_settings

[![Build Status](https://secure.travis-ci.org/marten/mongoid-app_settings.png)](http://travis-ci.org/marten/mongoid-app_settings)

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

# Contributing to mongoid-app_settings
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

== Copyright

Copyright (c) 2011 Marten Veldthuis. See LICENSE.txt for
further details.

