
module Paytunia
 class Ticker
      attr_accessor :high, :low, :volume, :bid, :ask, :midpoint, :at, :price, :variation, :currency

      def initialize args
        args.each do |k,v|
          self.send("#{k}=", v)
        end
      end


    end
end