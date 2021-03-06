module Paytunia
  module Api

    # Requests Bitcoins to be sent
    def send_bitcoins(address, amount)
      raise(TypeError, "Expected BigDecimal, got #{amount.class.name} instead.") unless amount.kind_of? BigDecimal
      account.post('/transfers/send_bitcoins', amount: amount, address: address)['uuid']
    end

  end
end