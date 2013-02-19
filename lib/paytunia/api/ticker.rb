module Paytunia
  module Api
    module Ticker
      def get_ticker
        public.get '/api/v1/ticker'
      end
    end
  end
end