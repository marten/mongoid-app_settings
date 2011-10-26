require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Mongoid::AppSettings" do
  let(:settings) do
    settings = Class.new 
    settings.instance_eval { include Mongoid::AppSettings }
    settings
  end

  let(:other_settings) do
    other_settings = Class.new
    other_settings.instance_eval { include Mongoid::AppSettings }
    other_settings
  end

  it "should be possible to save a setting" do 
    settings.instance_eval { setting :something }
    settings.something = "some nice value"
    settings.something.should == "some nice value"
  end

  it "should save settings outside of itself" do
    settings.instance_eval { setting :something }
    other_settings.instance_eval { setting :something }

    settings.something = "some nice value"
    other_settings.something.should == "some nice value"
  end

  it "should be possible to specify default values" do
    settings.instance_eval { setting :foo, :default => "bar" }
    settings.foo.should == "bar"
  end

  it "should be possible to overwrite a default value" do
    settings.instance_eval { setting :foo, :default => "bar" }
    settings.foo = "baz"
    settings.foo.should == "baz"
  end

  it "should not constantly reload" do
    settings.instance_eval { setting :foo }
    other_settings.instance_eval { setting :foo }
    other_settings.foo # force other_settings to load the record

    settings.foo = "bar"
    other_settings.foo.should be_nil
  end

  it "should be possible to reload" do
    settings.instance_eval { setting :foo }
    other_settings.instance_eval { setting :foo }
    other_settings.foo # force other_settings to load the record

    settings.foo = "bar"
    other_settings.reload
    other_settings.foo.should == "bar"
  end
end
