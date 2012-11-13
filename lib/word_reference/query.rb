require 'json'
require_relative 'translation'

module WordReference
  
  class Query

    attr_reader :translations

    def initialize(translations_array=[])
      @translations = translations_array
    end

    def self.from_json(api_data)
      terms = []
      new_query = self.new
      data = JSON::load(api_data)
      terms = terms_without_labels(data) # Removes term labels
      terms = clean_terms(terms) # Remove Original, LINES, and END hashes
      terms = term_translations(terms) # Strips everything but the actual translations
      
      # Create each translation object and add to translations array
      terms.each { |query_data| new_query.add_translation(Translation.from_query(query_data.values)) }
      new_query
    end

    def results
      @translations.map { |translation| translation }
    end

    def add_translation(translation)
      @translations << translation
    end

    def self.terms_without_labels(data)
      data.map { |term| term[1] }
    end

    def self.clean_terms(terms)
      3.times { terms.pop }
      terms
    end

    def self.term_translations(terms)
      terms.map { |translation| translation["PrincipalTranslations"].values }.flatten
    end

  end

end
