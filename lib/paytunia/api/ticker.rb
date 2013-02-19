module Paytunia
  module Api
    module Ticker
      def get_ticker
        get '/api/v1/ticker'
      end
    end
  end
end