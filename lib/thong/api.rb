module Thong
  class API
    require 'multi_json'
    require 'rest_client'

    CONFIG = Thong::Configuration.configuration
    THONG_URL = CONFIG[:thong_url]
    API_VERSION = "v1"
    ENDPOINT = "#{THONG_URL}/api/#{API_VERSION}"


    def self.post_json(endpoint, hash)
      disable_net_blockers!
      url = endpoint_to_url(endpoint)
      puts "[Thong] Submitting to #{ENDPOINT}".colorize(:cyan)
      response = RestClient.post(url, :json_file => hash_to_file(hash))
      response_hash = MultiJson.load(response.to_str)
      puts "[Thong] #{ response_hash['message'] }".colorize(:cyan)
      if response_hash['message']
        puts "[Thong] #{response_hash['url'].underline}".colorize(:cyan)
      end
    rescue RestClient::ServiceUnavailable
      puts "[Thong] API timeout ocurred, but data should still be processed".colorize(:red)
    rescue RestClient::InteralServerError
      puts "[Thong] API internal error occured, please check the log files in your Thong Server".colorize(:red)
    end

    private

    def self.disable_net_blockers!
      if defined?(WebMock) &&
        allow = WebMock::Config.instance.allow || []
        WebMock::Config.instance.allow = [*allow].push THONG_URL
      end
      
      if defined?(FakeWeb)
        allow = FakeWeb.allow_net_connect || []
        FakeWeb.allow_net_connect = [*allow].push THONG_URL
      end

      if defined?(VCR)
        VCR.send(VCR.version.major < 2 ? :config : :configure) do |c|
          c.ignore_hosts THONG_URL
        end
      end
    end

    def self.endpoint_to_url(endpoint)
      "#{ENDPOINT}/#{endpoint}"
    end

  end
end
