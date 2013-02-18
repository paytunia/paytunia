module Paytunia
  class Order
    attr_reader :amount ,:type, :created_at, :instructed_amount, :price, :state, :updated_at, :uuid

    def initialize args
      args.each do |k,v|
        instance_variable_set("@#{k}", v) unless v.nil?
      end
    end

  end
end