Dir.glob(File.dirname(__FILE__) + '/paytunia/**/*.rb').each { |file| require file }

# Override HTTParty's default JSON parser with monkeypatched pure parser
# because we'd like all float values to be deserialized as BigDecimal instances directly
require 'json/pure'

module JSON
  module Pure
    class Parser
      alias_method :parse_value_original, :parse_value

      def parse_value
        case
          when scan(FLOAT)
            BigDecimal(self[1])
          else
            parse_value_original
        end
      end
    end
  end
end

module HTTParty
  class Parser
    def json
      JSON.parse(body)
    end
  end
end

module Paytunia
  def self.method_missing(method, *args, &block)
    Paytunia::Connection.instance.respond_to?(method) ? Paytunia::Connection.instance.send(method, *args, &block) : super
  end
end