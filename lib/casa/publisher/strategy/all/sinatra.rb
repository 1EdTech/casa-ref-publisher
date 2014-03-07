require 'sinatra/json'
require 'casa/publisher/strategy/base/sinatra'

module CASA
  module Publisher
    module Strategy
      module All
        class Sinatra < CASA::Publisher::Strategy::Base::Sinatra

          def execute

            super do

              app.json from_handler.get_all.map(){ |payload|
                postprocess_handler ? postprocess_handler.execute(payload) : payload
              }.select(){ |payload|
                payload
              }

            end

          end

        end
      end
    end
  end
end
