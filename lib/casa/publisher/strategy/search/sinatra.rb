require 'sinatra/json'
require 'casa/publisher/strategy/base/sinatra'

module CASA
  module Publisher
    module Strategy
      module Search
        class Sinatra < CASA::Publisher::Strategy::Base::Sinatra

          #
          # Examples of legitimate calls:
          #
          #   curl [route]/_elasticsearch -XGET -d '{"query":{"match_all":{}}}'
          #   curl [route]/_elasticsearch -XGET -d '{"query":{"match_all":{}}}' -H "Content-type:application/json"
          #   curl [route]/_elasticsearch -XGET -d '{"query":{"match_all":{}}}' -H "Content-type:application/x-www-form-urlencoded"
          #   curl [route]/_elasticsearch -XGET -d '{"query":{"match_all":{}}}'
          #   curl [route]/_elasticsearch\?body\=%7B%22query%22%3A%7B%22match_all%22%3A%7B%7D%7D%7D
          #   http://[route]/_elasticsearch?body=%7B%22query%22%3A%7B%22match_all%22%3A%7B%7D%7D%7D
          #
          # Error codes:
          #
          #   400 - request body could not be parsed based on content-type
          #   406 - request specified an acceptable type server won't provide
          #   412 - if type specified does not match the persistence layer type
          #   415 - if content-type is not a supported content type
          #   449 - if type was not specified
          #   500 - server failed to provide from_handler persistence hander
          #   501 - if persistence layer does not support search
          #
          def execute

            super do

              payload = from_handler.get_search request_body

              app.json postprocess_handler ? postprocess_handler.execute(payload) : payload

            end

          end

          def process_request!

            super

            # 449 if client didn't specify a type -- although hitting this is likely the
            # server's fault for using this strategy when no app.params[:type] is defined
            app.error 449, 'Retry With' unless app.params[:type]

            # 412 if server cannot provide a search with the type specified
            app.error 412, 'Precondition Failed' unless app.params[:type] == from_handler.__type__

            # 501 if type specified does not support the search operation
            app.error 501, 'Not Implemented' unless from_handler.respond_to?(:get_search)

          end

        end
      end
    end
  end
end
