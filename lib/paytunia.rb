Dir.glob(File.dirname(__FILE__) + '/paytunia/**/*.rb').each { |file| require file }

# Override HTTParty's default JSON parser
require 'oj'

module HTTParty
  class Parser
    def json
      Oj.load(body)
    end
  end
end