require 'mongoid'

module Mongoid
  module AppSettings
    extend ActiveSupport::Concern

    class Record
      include Mongoid::Document
      identity type: String
      store_in :settings
    end

    module ClassMethods
      def method_missing(name, *args, &block)
        if name.to_s =~ /^(.*)=$/ and setting_defined?($1)
          self[$1] = args[0]
        elsif setting_defined?(name.to_s)
          self[name.to_s]
        else
          super
        end
      end

      def settings
        @settings ||= {}
      end

      def setting_defined?(name)
        settings.include?(name)
      end

      def setting(name, options = {})
        settings[name.to_s] = options
      end
      
      def record
        return @record if @record
        @record = Record.find_or_create_by(id: "settings")
      end

      def [](name)
        if record.attributes.include?(name)
          record.read_attribute(name)
        else
          settings[name][:default]
        end
      end

      def []=(name, value)
        record.set(name, value)
      end

      def reload
        @record = nil
      end
    end

  end
end
