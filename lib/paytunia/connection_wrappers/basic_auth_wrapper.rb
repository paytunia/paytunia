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
        do_request(:get, path)
      end

      def post(path, data)
        do_request(:post, path, data)
      end


      protected

      def do_request(method, path, data = nil)
        uri = URI.parse(@site + path)

        https = Net::HTTP.new(uri.host, 443)

        https.use_ssl = true

        https.verify_mode = OpenSSL::SSL::VERIFY_PEER
        https.ca_file = Paytunia::Connection::CA_FILE

        if method == :get
          request                 = Net::HTTP::Get.new(uri.request_uri)
        elsif method == :post
          request                 = Net::HTTP::Post.new(uri.request_uri)
          request.body            = JSON.dump(data)
          request['Content-Type'] = 'application/json'
          request['Accept']       = 'application/json'
        end

        request.basic_auth(@username, @password)

        response = https.request(request)
        status = response.code.to_i

        if status == 200
          JSON.parse(response.body)
        elsif status == 422
          raise JSON.parse(response.body)['error']
        elsif status == 404
          raise 'HTTP 404 - Not Found'
        elsif status == 401
          raise 'HTTP 403 - Forbidden'
        else
          raise 'Unknown response code.'
        end
      end
    end
  end
end