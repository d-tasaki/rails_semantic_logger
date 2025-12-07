module RailsSemanticLogger
  module SemanticLogger
    module BacktraceCleanedUtils
      def self.strip_backtrace(stack = caller)
        cleaner = Rails.backtrace_cleaner
        cleaner.clean(stack)
        super(stack)
      end
    end
  end
end

SemanticLogger::Utils.singleton_class.prepend(RailsSemanticLogger::SemanticLogger::BacktraceCleanedUtils)