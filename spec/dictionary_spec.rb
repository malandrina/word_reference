require_relative 'spec_helper'

describe WordReference::Dictionary do
  API_KEY = '12345'
  DICTIONARY = 'enfr'

  before do
    WordReference.configure { |config| config.api_key = API_KEY }
  end

  context '#initialize' do
    it 'inherits configuration from module' do
      dictionary = Dictionary.new(DICTIONARY)

      expect(dictionary.api_key).to eq API_KEY
    end

    it 'is initialized with a WordReference dictionary name' do
      dictionary = WordReference::Dictionary.new(DICTIONARY)

      expect(dictionary.name).to eq DICTIONARY
    end
  end

  context '#change_language' do
    it 'changes the WordReference dictionary' do
      dictionary = WordReference::Dictionary.new(DICTIONARY)

      expect{ dictionary.change_language('fren')
      }.to change { dictionary.instance_variable_get(:@name)
      }.from('enfr').to('fren')
    end
  end

  context '#query' do
    it 'queries the WordReference API' do
      dictionary = WordReference::Dictionary.new(DICTIONARY)
      search_term = 'key'
      word_reference_api = double('word_reference_api', query: double('body', body: '{}'))
      WordReferenceApi.stub(new: word_reference_api)
      response_parser = double('response_parser', run: stubbed_response)
      ResponseParser.stub(new: response_parser)

      dictionary.query(search_term)

      expect(word_reference_api).to have_received(:query)
    end

    it 'parses the response' do
      dictionary = WordReference::Dictionary.new(DICTIONARY)
      search_term = 'key'
      word_reference_api = double('word_reference_api', query: double('body', body: stubbed_response))
      WordReferenceApi.stub(new: word_reference_api)
      response_parser = double('response_parser', run: stubbed_response)
      ResponseParser.stub(new: response_parser)

      dictionary.query(search_term)

      expect(response_parser).to have_received(:run)
    end

    it 'returns the results of the query' do
      dictionary = WordReference::Dictionary.new(DICTIONARY)
      search_term = 'key'
      word_reference_api = double(
        'word_reference_api',
        query: double('body', body: stubbed_response)
      )
      WordReferenceApi.stub(new: word_reference_api)

      query = dictionary.query(search_term)

      expect(query).to respond_to(:results)
    end
  end

  def stubbed_response
    YAML.load_file('spec/wrjson.yml')
  end
end
