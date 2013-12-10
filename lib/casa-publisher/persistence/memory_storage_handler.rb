require 'casa-payload'
require 'casa-publisher/persistence/payload_validation_error'

module CASA
  module Publisher
    module Persistence
      class MemoryStorageHandler

        def initialize options = nil
          @payloads = {}
        end

        def create payload_hash, options = nil
          payload = CASA::Payload::TransitPayload.new payload_hash
          raise PayloadValidationError unless payload.validates?
          key = compute_key_from_identity payload.identity
          @payloads[key] = payload
        end

        def get payload_identity, options = nil
          key = compute_key_from_identity payload_identity
          return @payloads.include?(key) ? @payloads[key] : false
        end

        def get_all options = nil
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