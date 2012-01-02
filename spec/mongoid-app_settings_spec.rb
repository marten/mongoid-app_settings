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

  describe "defining settings" do
    it "should be possible to define a setting" do
      settings.instance_eval { setting :something }
      settings.something.should be_nil
    end

    it "should be possible to specify default values" do
      settings.instance_eval { setting :foo, :default => "bar" }
      settings.foo.should == "bar"
    end

    it "should be possible to use defaults of other settings in defaults" do
      settings.instance_eval { setting :foo, :default => "bar"
                              setting :baz, :default => "#{foo} quux" }
      settings.baz.should == "bar quux"
    end

    it "should be possible to use values of other settings in defaults" do
      settings.instance_eval { setting :foo, :default => "bar" }
      settings.foo = "baz"
      settings.instance_eval { setting :qux, :default => "#{foo} quux" }
      settings.qux.should === "baz quux"
    end

    it "should define fields on the record" do
      settings.instance_eval { setting :something }
      expect { 
        settings.send(:record).something 
      }.not_to raise_error(NoMethodError)
    end
  end

  describe "setting values" do
    it "should be possible to save a setting" do 
      settings.instance_eval { setting :something }
      settings.something = "some nice value"
      settings.something.should == "some nice value"
    end

    it "should save settings to mongodb" do
      settings.instance_eval { setting :something }
      other_settings.instance_eval { setting :something }

      settings.something = "some nice value"
      other_settings.something.should == "some nice value"
    end

    it "should be possible to overwrite a default value" do
      settings.instance_eval { setting :foo, :default => "bar" }
      settings.foo = "baz"
      settings.foo.should == "baz"
    end

    it "should be possible to overwrite a value with something else" do
      settings.instance_eval { setting :foo, :default => "bar" }
      settings.foo = "baz"
      settings.foo = "quux"
      settings.foo.should == "quux"
    end

    it "should be possible to unset a value, reverting to default" do
      settings.instance_eval { setting :foo, :default => "bar" }
      settings.foo = "baz"
      settings.delete(:foo)
      settings.foo.should == "bar"
    end

    it "should be possible to get a hash of all settings and their values" do
      settings.instance_eval { setting :one, :default => "One" }
      settings.instance_eval { setting :two, :default => "Two" }
      settings.instance_eval { setting :three, :default => "Three" }

      settings.two = "My value"
      settings.three = nil
      settings.all.should == {:one => "One", :two => "My value", :three => nil}
    end

    it "should be possible to overwrite a value with false" do
      # At one point, Mongoid didn't support Record#set with nil/false
      # This spec is here to prevent regression
      settings.instance_eval { setting :foo, :default => "bar" }
      settings.foo = "baz"
      settings.foo = false
      settings.foo.should == false
    end

    it "should be possible to overwrite a value with false" do
      # At one point, Mongoid didn't support Record#set with nil/false
      # This spec is here to prevent regression
      settings.instance_eval { setting :foo, :default => "bar" }
      settings.foo = "baz"
      settings.foo = nil
      settings.foo.should == nil
    end
  end

  describe "reload behaviour" do
    it "should not reload for every call" do
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
end
