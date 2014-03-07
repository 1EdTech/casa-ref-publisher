require 'sinatra/json'
require 'casa/publisher/strategy/base/sinatra'

module CASA
  module Publisher
    module Strategy
      module One
        class Sinatra < CASA::Publisher::Strategy::Base::Sinatra

          def execute

            super do

              payload = from_handler.get({
                'originator_id' => app.params[:originator_id],
                'id' => app.params[:id]
              })

              app.json postprocess_handler ? postprocess_handler.execute(payload) : payload

            end

          end

          def validate_request_content!

            super

            app.error 400, "Bad Request" unless app.params[:originator_id] and app.params[:id]

          end

        end
      end
    end
  end
end
