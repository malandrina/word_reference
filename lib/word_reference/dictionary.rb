require_relative 'response_parser'
require_relative 'word_reference_api'

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
      response = word_reference_api.query(url(term))
      response_parser = ResponseParser.new(response.body)
      response_parser.run
    end

    private

    def config
      WordReference::Configurable.keys.each do |key|
        instance_variable_set(
          :"@#{key}",
          WordReference.instance_variable_get(:"@#{key}")
        )
      end
    end

    def url(term)
      "#{BASE_URL}/0.8/#{api_key}/json/#{name}/#{term}"
    end

    def word_reference_api
      @word_reference_api ||= WordReferenceApi.new
    end
  end
end
