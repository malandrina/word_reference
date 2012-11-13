module WordReference

  module Configurable

    attr_writer :api_key

    # Array of key NAMES used to configure settings before
    # call to WordReference.com API is made
    class << self
      def keys
        @keys ||= [:api_key]
      end
    end

    def configure
      yield self
      self
    end

  end

end