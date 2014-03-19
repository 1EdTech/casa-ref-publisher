require 'sinatra/json'
require 'casa/publisher/strategy/base/sinatra'

module CASA
  module Publisher
    module Strategy
      module Query
        class Sinatra < CASA::Publisher::Strategy::Base::Sinatra

          def execute

            super do

              payload = from_handler.get_query app.params[:query]
              app.json postprocess_handler ? postprocess_handler.execute(payload) : payload

            end

          end

          def process_request!

            super

            # 449 if client didn't specify a query
            app.error 449, 'Retry With' unless app.params[:query]

            # 501 if type specified does not support the search operation
            app.error 501, 'Not Implemented' unless from_handler.respond_to?(:get_query)

          end

        end
      end
    end
  end
end
