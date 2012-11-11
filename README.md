# WordReference

Authors: [malandrina](https://github.com/malandrina), [sandbochs](https://github.com/sandbochs)

A Ruby wrapper for the [WordReference.com](http://www.wordreference.com) Dictionary API

Documentation for the API can be found here: http://www.wordreference.com/docs/api.aspx 

## TODO

- Handle exceptions
- Handle errors from WordReference.com API
- Add usage instructions for words with special characters
- Add interface for thesaurus API

## Installation

Add this line to your application's Gemfile:

    gem 'word_reference'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install word_reference

## Usage

Include WordReference module

```ruby
include WordReference
```

In order to query the WordReference.com API, you will need an API key. You can get one here: http://www.wordreference.com/docs/APIregistration.aspx

Configure your API key

```ruby
WordReference.configure do |config|
  config.api_key = YOUR_API_KEY
end
```

Create a new dictionary

A dictionary is referenced by a four-letter code comprising the original language and target language. Note that the WordReference.com API currently supports translations to or from English. If the dictionary does not exist (ex. 'czzh'), the API will return an error message. A list of two-letter language codes is provided below.

```ruby
french_dictionary = Dictionary.new('enfr')
```

- Arabic:     ar
- Chinese:    zh
- Czech:      cz
- English:    en
- French:     fr
- Greek:      gr
- Italian:    it
- Japanese:   ja
- Korean:     ko
- Polish:     pl
- Portuguese: pt
- Romanian:   ro
- Spanish:    es
- Turkish:    tr

Change dictionary

```ruby
french_dictionary.change_to('iten')
# Or create another dictionary
italian_dictionary = Dictionary.new('iten')
```

Query API with term

Query terms which include special characters should be converted to UTF-8 Base 16. ("más" => "m%C3%A1s")

[UTF Converter](http://macchiato.com/unicode/convert.html)

```ruby
# Returns a Query object
query = italian_dictionary.query('chiave')
```

Get query results

```ruby
# Returns an array of translations
query.get_results
```

When #query is called on a dictionary, a collection of translation objects is returned.

Get original term

```ruby
translation = query.get_results.first
translation.original => {"term"=>"chiave", "POS"=>"nf", "sense"=>"strumento per aprire", "usage"=>"letterale"}
translation.original['term'] => 'chiave'
translation.original['POS'] => 'nf' # 'POS' stands for 'Particle of Speech'
translation.original['sense'] => 'strumento per aprire'
translation.original['usage'] => 'letterale'
```

Get translations

```ruby
translation = query.get_results.first
first = translation.results.first
first => {"term"=>"key", "POS"=>"n", "sense"=>""}
first['term'] => 'key'
first['POS'] => 'n' # noun
first['sense'] => '' # no sense
first['usage'] => nil
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
