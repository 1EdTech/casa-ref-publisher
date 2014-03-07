module CASA
  module Publisher
    module Strategy
      module Base
        class Base

          attr_reader :from_handler
          attr_reader :postprocess_handler

          def initialize options = {}

            @from_handler = options['from_handler']
            @postprocess_handler = options.has_key?('postprocess_handler') ? options['postprocess_handler'] : false

          end

        end
      end
    end
  end
end