module RailsSemanticLogger
  module SemanticLogger
    module Formatters
      module BacktraceCleanedRaw
        def exception
          super
          return unless log.exception

          root = hash
          cleaner = Rails.backtrace_cleaner
          log.each_exception do |exception, i|
            name = i.zero? ? :exception : :cause
            root[name][:stack_trace] = cleaner.clean(root[name][:stack_trace] || [])
            root = root[name]
          end
        end
      end
    end
  end
end

SemanticLogger::Formatters::Raw.prepend(RailsSemanticLogger::SemanticLogger::Formatters::BacktraceCleanedRaw)
