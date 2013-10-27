require 'spec_helper'

describe ResponseParser, '#run' do
  it 'returns parsed results' do
    response = YAML.load_file('spec/wrjson.yml')

    response_parser = ResponseParser.new(response)
    parsed_response = response_parser.run

    expect(parsed_response.results.length).to eq 6
  end

  it 'returns a query object' do
    response = YAML.load_file('spec/wrjson.yml')

    response_parser = ResponseParser.new(response)
    parsed_response = response_parser.run

    expect(parsed_response.class).to eq Query
  end
end
