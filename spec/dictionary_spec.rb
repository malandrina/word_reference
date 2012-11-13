require_relative 'spec_helper'

describe WordReference::Dictionary do
  
  API_KEY = "12345"
  DICTIONARY = 'enfr'
  
  before do 
    WordReference.configure { |config| config.api_key = API_KEY }
  end

  let(:dictionary) { WordReference::Dictionary.new(DICTIONARY)}

  context "initialization" do
    it "inherits configuration from module" do
      dictionary.instance_variable_get(:@api_key).should eq (API_KEY)
    end

    it "is initialized with a WordReference dictionary name" do
      dictionary.instance_variable_get(:@name).should eq ("enfr")
    end
  end

  context "setting WordReference dictionary" do
    it "changes the WordReference dictionary" do
      expect{ dictionary.change_language('fren') 
      }.to change { dictionary.instance_variable_get(:@name) 
      }.from("enfr").to("fren")
    end
  end

  context "querying the WordReference API" do
    it "queries the WordReference API" do
      dictionary.should_receive(:api_call)
      Query.should_receive(:from_json)
      dictionary.query('term')
    end

    it "receives the body from the API" do
      term = 'hello'
      url = "http://api.wordreference.com/0.8/#{API_KEY}/json/#{DICTIONARY}/#{term}"
      FakeWeb.register_uri(:get, url, :body => "Bonjour")
      dictionary.send(:api_call, term).should eq "Bonjour"
    end
    
  end
  
end