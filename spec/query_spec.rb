require_relative '../lib/word_reference/configurable.rb'
require_relative '../lib/word_reference/query.rb'
require 'yaml'

include WordReference
include WordReference::Configurable

describe WordReference::Query do
  let(:query) { Query.new }
  let(:api_data) { YAML.load_file('spec/wrjson.yml') }

  it "adds a translation" do
    expect { query.add_translation(:term) }.to change {
             query.translations.length }.by(1)
  end

  it "can return the results" do
    query.add_translation(:term)
    query.get_results.should eq ([:term])
  end

  context "#self.from_json" do
    let(:query2) { Query.from_json(api_data) }
    let(:translation) { query2.get_results.first }

    it "creates a Query object from the api data" do
      query2.should be_instance_of(Query)
    end

    it "has the correct original term" do
      translation.original['term'].should eq('chiave')
    end

    it "has the correct translations" do
      translation.results.first.values.should include('key')
    end
  end

end