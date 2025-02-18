# frozen_string_literal: true

require 'http'

class PumaControlClient
  def initialize(url = nil, token: nil)
    @uri ||= ENV.fetch('PUMA_CONTROL_URL') { '0.0.0.0:9293' }
    @token ||= ENV.fetch('PUMA_CONTROL_URL_TOKEN') { 'zealot' }
  end

  def stats
    get 'stats'
  rescue HTTP::Error
    false
  end

  def restart
    get 'restart'
  end

  private

  def get(path)
    client.get(url(path), params: auth_token)&.parse(:json)
  end

  def url(path)
    "http://#{@uri}/#{path}"
  end

  def auth_token
    @auth_token ||= {
      token: @token
    }
  end

  def client
    @client ||= HTTP::Client.new(HTTP::Options.new(features: {
      logging: {
        logger: Logger.new(STDOUT)
      }
    }))
  end
end