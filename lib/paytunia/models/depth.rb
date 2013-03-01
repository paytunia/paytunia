module Paytunia
  module Api
    class Depth < Base
      attrs :amount, :price, :timestamp, :currency
    end
  end
end