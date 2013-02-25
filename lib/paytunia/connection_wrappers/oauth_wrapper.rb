module Paytunia
  module ConnectionWrappers
    class OAuthWrapper
      attr_reader :token, :site

      def initialize(token, site)
        @token = token
        @site = site
      end

      def get(path)
        JSON.parse(token.get(@site + path).body)
      end
    end
  end
end