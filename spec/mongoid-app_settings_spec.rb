require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Mongoid::AppSettings" do
  let(:settings) do
    settings = Class.new 
    settings.instance_eval { include Mongoid::AppSettings }
    settings
  end

  it "should be possible to save a setting" do 
    settings.something = "some nice value"
    settings.something.should == "some nice value"
  end

  it "should save settings outside of itself" do
    settings.something = "some nice value"
    fresh_settings = Class.new
    fresh_settings.instance_eval { include Mongoid::AppSettings }
    fresh_settings.something.should == "some nice value"
  end

  it "should be possible to specify default values" do
    settings.instance_eval do
      default :foo, "bar"
    end
    settings.foo.should == "bar"
  end

  it "should be possible to overwrite a default value" do
    settings.instance_eval { default :foo, "bar" }
    settings.foo = "baz"
    settings.foo.should == "baz"
  end
end
