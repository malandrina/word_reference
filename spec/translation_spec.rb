require_relative '../lib/word_reference/configurable.rb'
require_relative '../lib/word_reference/translation.rb'

include WordReference
include WordReference::Configurable

describe WordReference::Translation do

  context "from query" do
    let (:translation) { Translation.from_query([{ :original => true }, :results, :note]) }
    it "has an original term" do
      translation.original.should eq({ :original => true })
    end

    it "has translation results" do
      translation.results.should eq([:results])
    end
  end

end