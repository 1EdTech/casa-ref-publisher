require 'casa-payload'
require 'casa-publisher/storage/basic_handler_validation_error'

module CASA
  module Publisher
    module Storage
      class BasicHandler

        def initialize
          @payloads = {}
        end

        def create payload_hash
          payload = CASA::Payload::TransitPayload.new payload_hash
          raise BasicHandlerValidationError unless payload.validates?
          key = compute_key_from_identity payload.identity
          @payloads[key] = payload
        end

        def get payload_identity
          key = compute_key_from_identity payload_identity
          return @payloads.include?(key) ? @payloads[key] : false
        end

        def get_all
          return @payloads.values
        end

        private
        def compute_key_from_identity payload_identity
          hash = payload_identity.to_hash
          "#{hash['originator_id']}::#{hash['id']}"
        end

      end
    end
  end
end