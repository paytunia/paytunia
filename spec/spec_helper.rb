
require_relative '../lib/paytunia'
# For Ruby < 1.9.3, use this instead of require_relative
# require(File.expand_path('../../lib/dish', __FILE__))

#dependencies
require 'minitest/autorun'
require 'webmock/minitest'
require 'vcr'
require 'turn'

##Turn is more pleasant but doesn't render properly on my computer
#Turn.config do |c|
#  # :outline  - turn's original case/test outline mode [default]
#  c.format  = :outline
#  # turn on invoke/execute tracing, enable full backtrace
#  c.trace   = true
#  # use humanized test names (works only with :outline format)
#  c.natural = true
#end

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/paytunia_cassettes'
  c.hook_into :webmock
end