# -*- encoding: utf-8 -*-
require File.expand_path('../lib/word_reference/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Laila Winner", "Elliot Shiu"]
  gem.email         = ["laila.winner@gmail.com", "elliot@sandbochs.com"]
  gem.description   = %q{A Ruby wrapper for the WordReference.com Dictionary API}
  gem.summary       = %q{Client for the WordReference.com API}
  gem.homepage      = "https://github.com/malandrina/word_reference"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "word_reference"
  gem.require_paths = ["lib"]
  gem.version       = WordReference::VERSION
end
