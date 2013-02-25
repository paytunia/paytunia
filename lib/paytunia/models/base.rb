module Paytunia
  module Api
    class Base
      def initialize(args)
        args.each { |k, v| send("#{k}=", v) }
      end
    end
  end
end