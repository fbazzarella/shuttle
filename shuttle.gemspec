# -*- encoding: utf-8 -*-
require File.expand_path('../lib/shuttle/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Felipe Bazzarella"]
  gem.email         = ["fbazzarella@gmail.com"]
  gem.description   = %q{A simplest continuous integration for a Rails application. Enjoy it!}
  gem.summary       = %q{Get a new code from another team members, install new gems, run new migrations, run specs and send your new feature to the origin repository. At the simplest way!}

  gem.files         = `git ls-files`.split($\)
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "shuttle"
  gem.require_paths = ["lib"]
  gem.version       = Shuttle::VERSION

  gem.add_runtime_dependency('colored')
end
