require 'mongoid'
require 'mongoid/app_settings/version'

module Mongoid
  module AppSettings
    extend ActiveSupport::Concern

    included do |base|
      @base = base
    end

    class Record #:nodoc:
      include Mongoid::Document
      field :key, :type => String
      if Mongoid::VERSION > '3'
        store_in :collection => :settings
      else
        store_in 'settings'
      end
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

        Record.instance_eval do
          field name
        end

        @base.class.class_eval do
          define_method(name.to_s) do
            @base[name.to_s]
          end

          define_method(name.to_s + "=") do |value|
            @base[name.to_s] = value
          end
        end
      end
      
      # Force a reload from the database
      def reload
        @record = nil
      end

      # Unsets a set value, resetting it to its default
      def delete(setting)
        @record.unset(setting)
      end

      def all
        {}.tap do |result|
          settings.each do |setting, options|
            result[setting.to_sym] = self.send(setting)
          end
        end
      end

      def defaults
        {}.tap do |result|
          settings.each do |setting, options|
            result[setting.to_sym] = options[:default]
          end
        end
      end

      protected

      def settings # :nodoc:
        @settings ||= {}
      end

      def setting_defined?(name) # :nodoc:
        settings.include?(name)
      end

      def record # :nodoc:
        return @record if @record
        @record = Record.find_or_create_by(:key => "settings")
      end

      def [](name) # :nodoc:
        if record.attributes.include?(name)
          record.read_attribute(name)
        else
          settings[name][:default]
        end
      end

      def []=(name, value) # :nodoc:
        if value
          record.set(name, value)
        else 
          # FIXME Mongoid's #set doesn't work for false/nil.
          # Pull request has been submitted, but until then
          # this workaround is needed.
          record[name] = value
          record.save
        end
      end
    end
  end
end
