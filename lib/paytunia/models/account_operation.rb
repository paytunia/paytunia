module Paytunia
  module Api
    class AccountOperation < Base
      attrs :uuid, :amount, :currency, :created_at, :state, :type, :balance
    end
  end
end
