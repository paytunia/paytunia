require 'oauth2'
require 'httparty'
require 'singleton'
require 'io/console'

module Paytunia
  class Connection

    include Singleton
    include HTTParty

    include Paytunia::Api

    APP_ID      = '6fcf1c32f6e14cd773a7a6640832bdbf83a5b2b8d4382e839c6aff83a8f1bb3b'
    APP_SECRET  = '55554ecad5627f0465034c4a116e59a38d9c3ab272487a18404078ccc0b64798'

    CA_FILE     = File.dirname(__FILE__) + '/../../certs/ca-certificates.crt'

    SITE        = 'https://bitcoin-central.net/api/v1'

    def get(url)
      self.class.get(SITE + url)
    end

    def account
      @basic_auth_wrapper || @oauth2_wrapper || raise('No authenticated connection available')
    end

    def connect(credentials = nil)
      if credentials[:basic_auth]
        do_basic_auth_connect!(credentials[:basic_auth][:username], credentials[:basic_auth][:password])
      end

      if credentials[:oauth2] && !@basic_auth_wrapper
        do_oauth2_connect!(credentials[:oauth2][:username],
          credentials[:oauth2][:password],
          credentials[:oauth2][:access_token]
        )
      end

      unless @basic_auth_wrapper || @oauth2_wrapper
        raise 'No credentials provided, unable to request them interactively'
      end

      self
    end


    protected

    def do_basic_auth_connect!(username, password)
      @basic_auth_wrapper = Paytunia::ConnectionWrappers::BasicAuthWrapper.new(username, password, SITE)
    end

    def do_oauth2_connect!(username, password, access_token)
      if access_token
        # TODO : Implement me
      else
        client = OAuth2::Client.new(APP_ID, APP_SECRET,
          site: SITE,
          ssl: { ca_file: CA_FILE })

        @token = client.password.get_token(username, password, scope: 'read trade merchant')
      end
    end

    def self.method_missing(method, *args, &block)
      Paytunia::Connection.instance.respond_to?(method) ? Paytunia::Connection.instance.send(method, *args, &block) : super
    end
  end
end