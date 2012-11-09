require 'json'
require_relative './translation'

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
      data.each { |term| terms << term[1] } # Removes term numbers
      3.times { terms.pop } # Remove Original, LINES, and END hashes

      # Strips everything but the actual translations
      terms.map! { |translation| translation["PrincipalTranslations"].values }.flatten!

      
      terms.each { |query_data| new_query.add_translation(Translation.from_query(query_data.values)) }

      new_query
    end

    def add_translation(translation)
      @translations << translation
    end

  end

end
