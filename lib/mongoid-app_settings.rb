require 'mongoid'

module Mongoid
  module AppSettings
    extend ActiveSupport::Concern

    class Record #:nodoc:
      include Mongoid::Document
      identity :type => String
      store_in :settings
    end

    module ClassMethods
      # Defines a setting. Options can include:
      #
      # * default -- Specify a default value
      #
      # Example usage:
      #
      #   class MySettings
      #     include Mongoid::AppSettings
      #     setting :organization_name, :default => "demo"
      #   end
      def setting(name, options = {})
        settings[name.to_s] = options
      end
      
      # Force a reload from the database
      def reload
        @record = nil
      end

      protected

      def method_missing(name, *args, &block) # :nodoc:
        if name.to_s =~ /^(.*)=$/ and setting_defined?($1)
          self[$1] = args[0]
        elsif setting_defined?(name.to_s)
          self[name.to_s]
        else
          super
        end
      end

      def settings # :nodoc:
        @settings ||= {}
      end

      def setting_defined?(name) # :nodoc:
        settings.include?(name)
      end

      def record # :nodoc:
        return @record if @record
        @record = Record.find_or_create_by(:id => "settings")
      end

      def [](name) # :nodoc:
        if record.attributes.include?(name)
          record.read_attribute(name)
        else
          settings[name][:default]
        end
      end

      def []=(name, value) # :nodoc:
        record.set(name, value)
      end
    end
  end
end
