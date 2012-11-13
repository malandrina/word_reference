require_relative 'spec_helper'

describe WordReference::Query do
  let(:query) { Query.new }
  let(:api_data) { YAML.load_file('spec/wrjson.yml') }

  it "adds a translation" do
    expect { query.add_translation(:term)
    }.to change { query.translations.length 
    }.by(1)
  end

  it "can return the results" do
    query.add_translation(:term)
    query.results.should eq ([:term])
  end

  context "#self.from_json" do
    let(:query2) { Query.from_json(api_data) }
    let(:translation) { query2.results.first }

    it "has the correct original search term" do
      translation.search_term['term'].should eq('chiave')
    end

    it "has the correct translations" do
      translation.results.first.values.should include('key')
    end
  end

end