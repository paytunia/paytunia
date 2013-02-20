require 'oauth2'
require 'httparty'
require 'singleton'
require 'io/console'

module Paytunia

  @@cli = false

  def self.cli
    @@cli
  end

  def self.cli!
    @@cli = true
  end

  class Connection

    include Singleton

    include HTTParty

    include Paytunia::Api::Order
    include Paytunia::Api::Trading
    include Paytunia::Api::Ticker

    APP_ID      = '6fcf1c32f6e14cd773a7a6640832bdbf83a5b2b8d4382e839c6aff83a8f1bb3b'
    APP_SECRET  = '55554ecad5627f0465034c4a116e59a38d9c3ab272487a18404078ccc0b64798'

    SITE        = 'https://bitcoin-central.net'

    def get(url)
      self.class.get(SITE + url).body
    end

    def token
      @token ||= connect
    end

    def connect(credentials = nil)
      unless credentials
        if Paytunia.cli
          print 'Account ID: '
          username = $stdin.gets.chomp

          print 'Password: '
          password = STDIN.noecho { $stdin.gets; print "\n" }.chomp
        else
          raise 'No credentials provided, unable to request them interactively'
        end
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