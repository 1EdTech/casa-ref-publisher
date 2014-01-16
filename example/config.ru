require 'pathname'
require 'json'
require 'casa/publisher'

# Use the basic storage handler for this example
# In production, this should be a database-backed handler
handler = CASA::Publisher::Persistence::MemoryStorageHandler.new

# For the basic storage handler, load payloads from the data directory
Dir.glob(Pathname.new(__FILE__).parent.realpath + "data/**/*.json").each do |payload_file|
  begin
    handler.create JSON.parse File.read payload_file
    puts "[config.ru] Loaded #{payload_file}"
  rescue JSON::ParserError
    puts "[config.ru] Skipping #{payload_file} -- Invalid JSON"
  rescue CASA::Publisher::Persistence::PayloadValidationError
    puts "[config.ru] Skipping #{payload_file} -- Invalid TransitPayload Structure"
  end
end

# Attach the storage handler to the Publisher App
CASA::Publisher::App.set_storage_handler handler

# Run the Publisher App
run CASA::Publisher::App