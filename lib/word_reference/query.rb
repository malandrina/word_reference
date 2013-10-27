require 'json'
require_relative 'translation'

module WordReference
  class Query
    attr_reader :translations

    def initialize(translations = [])
      @translations = translations
    end

    def results
      @translations.map { |translation| translation }
    end

    def add_translation(translation)
      @translations << translation
    end
  end
end
