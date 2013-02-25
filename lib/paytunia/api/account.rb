module Paytunia
  module Api

    # Returns the list of account operations
    def get_ledger
      token.get('account_operations').body
    end

  end
end