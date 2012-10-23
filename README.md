# Shuttle

A simplest continuous integration for a Rails application. Enjoy it!

Get a new code from another team members, install new gems, run new migrations, run specs and send your new feature to the origin repository. At the simplest way!

## Installation

Add this line to your application's Gemfile:

    gem 'shuttle'

Install the gem with Bundler:

    $ bundle

And then configure default Shuttle Steps:

    $ rails g shuttle:install

## Usage

    $ rake shuttle

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
