module Paytunia
  module Api
    class AccountOperation < Base
      attrs :uuid, :amount, :currency, :created_at, :state, :type, :balance, :created_at_int
    end
  end
end
