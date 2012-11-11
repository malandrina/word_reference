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

  it "should create a Query object from the api data" do
    Query.from_json(api_data).should be_instance_of(Query)
  end

end