require_relative 'spec_helper'

describe Query, '#results' do
  it 'returns results' do
    query = Query.new

    query.add_translation(:term)

    query.results.should eq ([:term])
  end
end

describe Query, '#add_translation' do
  it 'adds translation to results' do
    query = Query.new

    expect {
      query.add_translation(:term)
    }.to change {
      query.translations.length
    }.by(1)
  end
end
