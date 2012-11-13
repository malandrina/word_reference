require_relative 'spec_helper'

describe WordReference::Translation do

  context "from query" do
    let (:translation) { Translation.from_query([{ :original => true }, :results, :note]) }
    it "has an original term" do
      translation.search_term.should eq({ :original => true })
    end

    it "has translation results" do
      translation.results.should eq([:results])
    end
  end

end