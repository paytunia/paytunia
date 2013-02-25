module Paytunia
  module Api
    class Ticker
      attr_accessor :high, :low, :volume, :bid, :ask, :midpoint, :at, :price, :variation, :currency

      def initialize args
        args.each { |k,v| send("#{k}=", v) }
      end
    end
  end
end