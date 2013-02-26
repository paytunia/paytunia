require_relative '../spec_helper'

describe 'Send money' do
  describe 'send_bitcoins' do

    let :transfer do
      VCR.use_cassette('transfer', match_requests_on: [:method, :anonymized_uri]) do
        Paytunia.send_bitcoins('1DavouTAsveznCFHsz688xvbrRAq4u2qm8', BigDecimal('1'))
      end
    end

    it 'should return an UUID' do
      transfer.should be_an_instance_of String
      transfer.should be_a_valid_uuid
    end

    it 'should fail if amount is not a BigDecimal' do
      expect { Paytunia.send_bitcoins('foo', 1.234) }.to raise_error
    end

  end
end