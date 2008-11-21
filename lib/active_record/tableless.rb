module ActiveRecord
  module Tableless
    def self.included(base)
        base.extend(ClassMethods)
    end
    
    module ClassMethods
      def tableless
        include ActiveRecord::Tableless::InstanceMethods
      end
      
      def columns()
        @columns ||= []
      end
      
      def column(name, sql_type = nil, default = nil, null = true)
        columns << ActiveRecord::ConnectionAdapters::Column.new(name.to_s, default, sql_type.to_s, null)
        reset_column_information
      end
      
      # Do not reset @columns
      def reset_column_information
        generated_methods.each { |name| undef_method(name) }
        @column_names = @columns_hash = @content_columns = @dynamic_methods_hash = @read_methods = nil
      end
    end
    
    module InstanceMethods 
      def create_or_update
        errors.empty?
      end
    end
    
  end
end