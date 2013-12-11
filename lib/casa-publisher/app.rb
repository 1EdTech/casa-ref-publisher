require 'sinatra/base'
require 'sinatra/json'
require 'casa-publisher/persistence/memory_storage_handler'

module CASA
  module Publisher
    class App < Sinatra::Base

      @@storage_handler = false

      def self.set_storage_handler handler
        @@storage_handler = handler
      end

      get '/payloads' do

        begin
          request.accept? 'application/json'
        rescue
          error 406, "Not Acceptable"
        end

        error 501, "Not Implemented" unless @@storage_handler

        # NOTE: error 415 should be thrown if client processes body and unsupported request Content-Type
        # NOTE: error 400 should be thrown if client processes body and it is malformed per the Content-Type

        json @@storage_handler.get_all

      end

    end
  end
end
