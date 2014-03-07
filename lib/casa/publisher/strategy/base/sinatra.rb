require 'casa/publisher/strategy/base/base'
require 'json'

module CASA
  module Publisher
    module Strategy
      module Base
        class Sinatra < Base

          attr_reader :app
          attr_reader :request_body

          def initialize app, options = {}

            super options
            @app = app
            @request_body = nil

          end

          def execute

            validate_request!
            process_request!

            yield if block_given?

          end

          def validate_request!

            validate_implementation!
            validate_request_accept!

          end

          def validate_request_accept!

            begin
              app.request.accept? 'application/json'
            rescue
              app.error 406, 'Not Acceptable'
            end

          end

          def validate_implementation!

            app.error 500, 'Not Implemented' unless @from_handler

          end

          def process_request!

            app.request.body.rewind

            body = app.request.body.read.strip
            if body.length == 0 and app.params[:body]
              body = app.params[:body].strip
            end

            if body.length > 0
              set_request_body body
            else
              @request_body = nil
            end

          end

          private

          def set_request_body body

            case app.request.content_type

              when 'application/json',                  # CASA-specified value (should)
                   'application/x-www-form-urlencoded', # default XHR value (may)
                   nil                                  # default XHR value (may)

                set_json_request_body body

              else

                app.error 415, 'Unsupported media type'

            end

          end

          def set_json_request_body body

            begin

              @request_body = JSON.parse body

            rescue ::JSON::ParserError

              app.error 400, 'Bad Request'

            end

          end

        end
      end
    end
  end
end