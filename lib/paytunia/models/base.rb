module Paytunia
  module Api
    class Base
      def initialize(args)
        args.each do |k, v|
          val = (k =~ /_at$/) ? DateTime.parse(v) : v
          send("#{k}=", val)
        end
      end
    end
  end
end