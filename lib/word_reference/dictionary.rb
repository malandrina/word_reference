require 'open-uri'
require 'net/http'
require_relative './query'

module WordReference
  
  class Dictionary
    include WordReference
    include WordReference::Configurable

    attr_reader :name, :api_key

    def initialize(dictionary_name)
      # comments
      WordReference::Configurable.keys.each do |key|
        instance_variable_set(:"@#{key}", WordReference.instance_variable_get(:"@#{key}"))
      end

      @name = dictionary_name
    end

    def change_to(dictionary_name)
      @name = dictionary_name
    end

    def query(term)
      data = api_call(term)
      Query.from_json(data)
    end

    #private

    def api_call(term)
      Net::HTTP.get_response(URI.parse(url(term))).body
    end

    def url(term)
      base_url = "http://api.wordreference.com"
      "#{base_url}/0.8/#{api_key}/json/#{name}/#{term}"
    end

  end

end