require 'open-uri'
require 'net/http'
require_relative 'query'

module WordReference
  
  class Dictionary
    include WordReference
    include WordReference::Configurable

    attr_reader :name, :api_key

    BASE_URL = "http://api.wordreference.com"

    def initialize(dictionary_name)
      @name = dictionary_name
      config
    end

    def change_language(dictionary_name)
      @name = dictionary_name
    end

    def query(term)
      Query.from_json(api_call(term))
    end

    private

    # Configures each setting for API call
    def config
      WordReference::Configurable.keys.each do |key|
        instance_variable_set(:"@#{key}", WordReference.instance_variable_get(:"@#{key}"))
      end
    end

    ### test using #send
    ### use FakeWeb
    ## testing that get_response is being called on Net::HTTP and that parse is being called on URI
    def api_call(term)
      Net::HTTP.get_response(URI.parse(url(term))).body
    end

    def url(term)
      "#{BASE_URL}/0.8/#{api_key}/json/#{name}/#{term}"
    end

  end

end