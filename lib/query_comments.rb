require 'query_comments/railtie'

module QueryComments
  mattr_accessor :comment, :application_name

  module ActiveRecordInstrumentation
    def self.included(instrumented_class)
      instrumented_class.class_eval do
        alias_method_chain :execute, :query_comments
      end
    end

    def execute_with_query_comments(sql, name = nil)
      execute_without_query_comments("#{sql} /*#{QueryComments.comment}*/", name)
    end
  end

end
