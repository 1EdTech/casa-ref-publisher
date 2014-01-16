require 'test/unit'
require 'rack/test'
require 'casa/payload'
require 'casa/publisher/app'

class TestCASAPublisherApp < Test::Unit::TestCase

  include Rack::Test::Methods

  def app
    @storage_handler = CASA::Publisher::Persistence::MemoryStorageHandler.new
    CASA::Publisher::App.set_storage_handler @storage_handler
    CASA::Publisher::App
  end

  def test_response

    get '/payloads'
    assert last_response.status == 200
    assert last_response.headers['Content-Type'].match /(^|\s)application\/json\s*;/
    assert last_response.headers['Content-Type'].match /;\s*charset=utf-8\s*(;|$)/
    assert JSON.parse(last_response.body).size == 0

    get '/payloads', {}, 'HTTP_ACCEPT' => '*/*'
    assert last_response.status == 200

    get '/payloads', {}, 'HTTP_ACCEPT' => 'application/*'
    assert last_response.status == 200

    get '/payloads', {}, 'HTTP_ACCEPT' => 'application/json'
    assert last_response.status == 200

    get '/payloads', {}, 'HTTP_ACCEPT' => 'text/html'
    assert last_response.status == 406

    CASA::Publisher::App.set_storage_handler false
    assert !CASA::Publisher::App.storage_handler
    get '/payloads'
    assert last_response.status == 501

    temp_storage_handler = CASA::Publisher::Persistence::MemoryStorageHandler.new

    CASA::Publisher::App.set_storage_handler temp_storage_handler
    assert CASA::Publisher::App.storage_handler == temp_storage_handler

    temp_storage_handler.create({
      'identity' => {
        'id' => '1',
        'originator_id' => '533a8d6e-008f-422d-bc09-0828ea499cef'
      },
      'original' => {
        'timestamp' => '1996-12-19T16:39:57-08:00',
        'uri' => 'http://example.com',
        'share' => true,
        'propagate' => true
      }
    })

    get '/payloads'
    response_body = JSON.parse(last_response.body)
    assert response_body.is_a? Array
    assert response_body[0]['identity']['originator_id'] = '533a8d6e-008f-422d-bc09-0828ea499cef'

    CASA::Publisher::App.set_storage_handler @storage_handler
    assert CASA::Publisher::App.storage_handler == @storage_handler

  end

end