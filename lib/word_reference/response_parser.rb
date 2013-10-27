require_relative 'query'
require_relative 'translation'

module WordReference
  class ResponseParser
    def initialize(response)
      @response = response
      @query = Query.new
    end

    def run
      query_results = sanitized_response

      query_results.each do |query_result|
        translation = Translation.from_query(query_result.values)
        query.add_translation(translation)
      end

      query
    end
  end

  private

  attr_reader :query, :response

  def clean_terms(terms)
    3.times { terms.pop }
    terms
  end

  def json_response
    JSON::load(response)
  end

  def sanitized_response
    terms = terms_without_labels(json_response)
    terms = clean_terms(terms) # Remove Original, LINES, and END hashes
    term_translations(terms) # Strips everything but the actual translations
  end

  def term_translations(terms)
    terms.map do |translation|
      translations_key(translation).values
    end.flatten
  end

  def terms_without_labels(data)
    data.map { |term| term[1] }
  end

  def translations_key(translation)
    translation['PrincipalTranslations'] || translation['Entries']
  end
end
