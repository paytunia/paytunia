require(File.expand_path('../../lib/paytunia', __FILE__))

require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
end