require 'open-uri'
require 'net/http'

module WordReference
  class WordReferenceApi
    def query(request_url)
      url = request_uri(request_url)
      Net::HTTP.get_response(url)
    end

    private

    def request_uri(request_url)
      URI.parse(request_url)
    end
  end
end
