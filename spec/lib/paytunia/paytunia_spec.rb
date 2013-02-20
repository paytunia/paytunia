require_relative '../../spec_helper'

describe Paytunia do
  it "must work" do
    "Rspec working".must_be_instance_of String
  end

  describe "default configuration" do
    it "must include httparty methods" do
      Paytunia::Connection.must_include HTTParty
    end

  end

end