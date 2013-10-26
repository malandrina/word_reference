require 'spec_helper'

describe WordReferenceApi, '#query' do
  it 'queries the WordReference API' do
    Net::HTTP.stub(get_response: true)

    word_reference_api = WordReferenceApi.new
    word_reference_api.query(request_url)

    expect(Net::HTTP).to have_received(:get_response).with(request_uri)
  end

  def request_url
    'http://api.wordreference.com/0.8/123/json/enfr/cle'
  end

  def request_uri
    URI.parse(request_url)
  end
end
