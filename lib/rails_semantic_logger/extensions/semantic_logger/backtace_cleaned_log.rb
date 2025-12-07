module RailsSemanticLogger
  module SemanticLogger
    module BacktraceCleanedLog
      def backtrace_to_s
        trace = ""
        cleaner = Rails.backtrace_cleaner
        each_exception do |exception, i|
          if i.zero?
            trace = (cleaner.clean(exception.backtrace || [])).join("\n")
          else
            trace << "\nCause: #{exception.class.name}: #{exception.message}\n#{(cleaner.clean(exception.backtrace || [])).join("\n")}"
          end
        end
        trace
      end

      def extract_file_and_line(stack, short_name = false)
        stack = Rails.backtrace_cleaner.clean(stack)
        super(stack, short_name)
      end
    end
  end
end

SemanticLogger::Log.prepend(RailsSemanticLogger::SemanticLogger::BacktraceCleanedLog)
