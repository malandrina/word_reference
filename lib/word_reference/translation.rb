module WordReference

  class Translation

    attr_reader :search_term, :results

    def initialize
      @search_term = {}
      @results = []
    end

    def self.from_query(data_array)
      trans = self.new
      trans.send(:strip_note!, data_array)
      trans.send(:set_search_term!, data_array.shift)
      trans.send(:set_translations!, data_array)
      trans
    end

    private

    # Results from the WordReference.com API include
    # a 'note' field that is rarely populated and
    # does not seem very useful.
    def strip_note!(data_array)
      data_array.pop
    end

    def set_search_term!(original_hash)
      search_term.replace(original_hash)
    end

    def set_translations!(translations_array)
      results.replace(translations_array)
    end

  end

end