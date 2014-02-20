require 'sinatra/json'

module CASA
  module Publisher
    module Strategy
      class Sinatra

        attr_reader :app
        attr_reader :from_handler
        attr_reader :postprocess_handler

        def initialize app, options = {}

          @app = app
          @from_handler = options['from_handler']
          @postprocess_handler = options.has_key?('postprocess_handler') ? options['postprocess_handler'] : false

        end

        def execute

          validate_request!
          generate_response

        end

        def generate_response

          app.json from_handler.get_all.map(){ |payload|
            postprocess_handler ? postprocess_handler.execute(payload) : payload
          }.select(){ |payload|
            payload
          }

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

        end

      end
    end
  end
end
