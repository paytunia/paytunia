module Paytunia
  module Api
    class Base
      def initialize(args)
        args.each do |k, v|
          val = (k =~ /_at$/) ? DateTime.parse(v) : v
          send("#{k}=", val)
        end
      end

      def self.inherited(child)
        child.instance_eval do
          def attrs(*args)
            attr_accessor *args
            @attr_list = args
          end
        end
      end

      def to_json(*args)
        h = self.class.instance_variable_get(:@attr_list).inject({}) do |memo, att|
          memo[att] = send(att)
          memo
        end

        JSON.generate(h)
      end
    end
  end
end