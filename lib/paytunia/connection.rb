require 'oauth2'
require 'httparty'
require 'singleton'
require 'io/console'

module Paytunia

  class Connection

    include Singleton

    include HTTParty

    include Paytunia::Api::Account
    include Paytunia::Api::Trading

    APP_ID      = '6fcf1c32f6e14cd773a7a6640832bdbf83a5b2b8d4382e839c6aff83a8f1bb3b'
    APP_SECRET  = '55554ecad5627f0465034c4a116e59a38d9c3ab272487a18404078ccc0b64798'

    SITE        = 'https://bitcoin-central.net/api/v1'

    def get(url)
      self.class.get(SITE + url)
      #self.class.get(SITE + url).body => if .body, then send back a string and not an hash!
    end

    def token
      @token ||= connect
    end

    def connect(credentials = nil)
      unless credentials
        raise 'No credentials provided, unable to request them interactively'
      end

      client = OAuth2::Client.new(APP_ID, APP_SECRET,
        site: SITE,
        ssl: { ca_file: File.dirname(__FILE__) + '/../../certs/ca-certificates.crt' })

      @token = client.password.get_token(username, password, scope: 'read trade merchant')
    end

    def self.method_missing(method, *args, &block)
      instance.respond_to?(method) ? instance.send(method, *args, &block) : super
    end
  end
end