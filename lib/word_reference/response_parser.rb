require_relative 'query'
require_relative 'translation'

module WordReference
  class ResponseParser
    def initialize(response)
      @response = response
    end

    def run
      terms = []
      data = JSON::load(response)
      terms = terms_without_labels(data) # Removes term labels
      terms = clean_terms(terms) # Remove Original, LINES, and END hashes
      terms = term_translations(terms) # Strips everything but the actual translations

      # Create each translation object and add to translations array
      new_query = Query.new
      terms.each do |query_data|
        translation = Translation.from_query(query_data.values)
        new_query.add_translation(translation)
      end
      new_query
    end
  end

  private

  attr_reader :response

  def terms_without_labels(data)
    data.map { |term| term[1] }
  end

  def clean_terms(terms)
    3.times { terms.pop }
    terms
  end

  def term_translations(terms)
    terms.map do |translation|
      translation["PrincipalTranslations"].values
    end.flatten
  end
end
