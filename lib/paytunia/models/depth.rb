module Paytunia
  module Api
    class Depth < Base
      attr_accessor :amount, :price, :timestamp, :currency
    end
  end
end