require_relative '../spec_helper'

describe 'Paytunia::Api.get_ledger' do

  let (:ledger) do
     VCR.use_cassette('ledger', match_requests_on: [:method, :anonymized_uri]) do
       Paytunia.get_ledger
     end
   end

  it 'must return the ledger' do
    ledger.should be_an_instance_of Array
    ledger.last.balance.should be_an_instance_of BigDecimal
  end

end
