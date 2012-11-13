require_relative 'word_reference/version'
require_relative 'word_reference/configurable'
require_relative 'word_reference/dictionary'

module WordReference

  # Includes Configurable module as long as WordReference
  # is also included in application
  def self.included(receiver)
    receiver.send(:include, WordReference::Configurable)
  end

end
