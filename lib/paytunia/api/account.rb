module Paytunia
  module Api

    # Returns the list of account operations
    def get_ledger
      account.get('/account_operations').map do |ao|
        AccountOperation.new(ao)
      end
    end

    # Returns a single account operation
    def get_operation(operation_id)
      AccountOperation.new(account.get("/account_operations/#{operation_id}"))
    end

    # Returns account balances
    def get_balances
      Balances.new(account.get("/balances"))
    end


  end
end
