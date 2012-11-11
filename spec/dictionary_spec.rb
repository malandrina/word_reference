require_relative '../lib/word_reference/configurable.rb'
require_relative '../lib/word_reference/dictionary.rb'

include WordReference
include WordReference::Configurable

describe WordReference::Dictionary do

  before do 
    WordReference.configure { |config| config.api_key = "12345" }
  end

  let(:dictionary) { WordReference::Dictionary.new('enfr')}

  context "initialization" do
    it "inherits configuration from module" do
      dictionary.instance_variable_get(:@api_key).should eq ("12345")
    end

    it "is initialized with a WordReference dictionary name" do
      dictionary.instance_variable_get(:@name).should eq ("enfr")
    end
  end

  context "setting WordReference dictionary" do
    it "changes the WordReference dictionary" do
      expect{ dictionary.change_to('fren') }.to change { 
              dictionary.instance_variable_get(:@name) }.from("enfr").to("fren")
    end
  end

  context "querying the WordReference API" do
    it "queries the WordReference API" do
      dictionary.query('term').should be_instance_of(Query)
    end
  end
  
end