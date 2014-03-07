require 'casa/publisher/strategy/base/base'

module CASA
  module Publisher
    module Strategy
      module Base
        class Sinatra < Base

          attr_reader :app

          def initialize app, options = {}

            super options
            @app = app

          end

          def execute

            validate_request!

            yield if block_given?

          end

          def validate_request!

            validate_implementation!
            validate_request_accept!
            validate_request_content_type!
            validate_request_content!

          end

          def validate_request_accept!

            begin
              app.request.accept? 'application/json'
            rescue
              app.error 406, "Not Acceptable"
            end

          end

          def validate_implementation!

            app.error 501, "Not Implemented" unless @from_handler

          end

          def validate_request_content_type!

            # NOTE: error 415 should be thrown if client processes body and unsupported request Content-Type

          end

          def validate_request_content!

            # NOTE: error 400 should be thrown if client processes body and it is malformed per the Content-Type
            # NOTE:

          end

        end
      end
    end
  end
end