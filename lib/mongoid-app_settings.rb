require 'mongoid'

module Mongoid
  module AppSettings
    extend ActiveSupport::Concern

    class Record
      include Mongoid::Document
      identity type: String
    end

    module ClassMethods
      def method_missing(name, *args, &block)
        if name.to_s =~ /^(.*)=$/
          set_value($1, args[0])
        else
          get_value(name.to_s)
        end
      end

      def defaults
        @defaults ||= {}
      end

      def default(name, value)
        defaults[name.to_s] = value
      end
      
      def record
        return @record if @record
        @record = Record.find_or_create_by(id: "settings")
      end

      def get_value(name)
        if record.attributes.include?(name)
          record.read_attribute(name)
        else
          defaults[name]
        end
      end

      def set_value(name, value)
        record.write_attribute(name, value)
        record.save
      end
    end

  end
end
