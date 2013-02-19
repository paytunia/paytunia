require 'oauth2'

module Paytunia
  class Connection

    include Singleton

    APP_ID      = '6fcf1c32f6e14cd773a7a6640832bdbf83a5b2b8d4382e839c6aff83a8f1bb3b'
    APP_SECRET  = '55554ecad5627f0465034c4a116e59a38d9c3ab272487a18404078ccc0b64798'

    SITE        = 'https://bitcoin-central.net'

    attr_accessor :token

    def initialize(credentials)
      client = OAuth2::Client.new(APP_ID, APP_SECRET, site: SITE)
      @token = client.password.get_token(credentials[:username], credentials[:password])
    end

    def self.method_missing(method, *args, &block)
      instance.respond_to?(method) ? instance.send(method, *args, &block) : super
    end
  end
end