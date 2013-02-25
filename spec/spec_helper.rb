require(File.expand_path('../../lib/paytunia', __FILE__))

require 'vcr'
require 'uri'

USERNAME = 'foo'
PASSWORD = 'bar'

def connect_paytunia!
  Paytunia.connect(basic_auth: {username: ENV['USERNAME'] || USERNAME, password: ENV['PASSWORD'] || PASSWORD})
end

RSpec.configure do |config|
  config.before(:all) { connect_paytunia! }
end

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock

  # Removes all private data (Basic Auth, Set-Cookie headers...)
  c.before_record do |i|

    i.response.headers.delete('Set-Cookie')
    i.request.headers.delete('Authorization')

    u = URI.parse(i.request.uri)
    i.request.uri.sub!(/:\/\/.*#{Regexp.escape(u.host)}/, "://#{u.host}" )

  end

  # Matches authenticated requests regardless of their Basic auth string (https://user:pass@domain.tld)
  c.register_request_matcher :anonymized_uri do |request_1, request_2|
    (URI(request_1.uri).port == URI(request_2.uri).port) &&
      (URI(request_1.uri).path == URI(request_2.uri).path) &&
      (URI(request_1.uri).host == URI(request_2.uri).host) &&
      (URI(request_1.uri).query == URI(request_2.uri).query)
  end
end