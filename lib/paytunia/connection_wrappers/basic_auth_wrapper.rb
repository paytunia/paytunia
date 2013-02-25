require 'net/https'
require 'uri'

module Paytunia
  module ConnectionWrappers
    class BasicAuthWrapper

      def initialize(username, password, site)
        @username = username
        @password = password
        @site = site
      end

      def get(path)

        uri = URI.parse(@site + path)

        https = Net::HTTP.new(uri.host, 443)

        https.use_ssl = true

        https.verify_mode = OpenSSL::SSL::VERIFY_PEER
        https.ca_file = Paytunia::Connection::CA_FILE

        request = Net::HTTP::Get.new(uri.request_uri)

        request.basic_auth(@username, @password)

        JSON.parse(https.request(request).body)
      end
    end
  end
end