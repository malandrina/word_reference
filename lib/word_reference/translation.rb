module WordReference

  class Translation

    attr_reader :original, :results

    def initialize
      @original = {}
      @results = []
    end

    def self.from_query(data_array)
      data_array.pop # Remove 'note'
      trans = self.new
      trans.set_original(data_array.shift)
      trans.set_translations(data_array)
      trans
    end

    def set_original(original_hash)
      original.replace(original_hash)
    end

    def set_translations(translations_array)
      results.replace(translations_array)
    end

  end

end