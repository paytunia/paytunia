module Paytunia
  module Api
    class AccountOperation < Base
      attr_accessor :uuid, :amount, :currency, :created_at, :state, :type, :balance
    end
  end
end
