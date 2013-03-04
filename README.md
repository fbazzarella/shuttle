# Shuttle

A simple continuous integration for a Rails application. Enjoy it!

Get a new code from another team members, install new gems, run new migrations, run specs, send your new feature to the origin repository and deploy your application. At simplest way!

## Installation

Add this line into your application's Gemfile:

    gem 'shuttle'

Install the gem with Bundler:

    $ bundle

## Configuration

And then configure default Shuttle Steps:

    $ rails g shuttle:install
    
This will create a configuration file in `config/shuttle.yml` who looks like this:

    steps:
      - shuttle:git:check
      - shuttle:git:pull
      - shuttle:bundle
      - db:migrate
      - shuttle:spec
      - shuttle:git:push
      # - log:clear
      # - tmp:clear

    # stages:
    #   staging:    your@server.com:staging-repository.git
    #   production: your@server.com:production-repository.git

### Understanding

#### Shuttle Steps

The steps are nothing more than Rake tasks, performed at the integration time. The array steps order will be the execution order. You have the freedom to rearrange, add or delete steps according to your need.

##### Shuttle's pre-defined Steps:

* `shuttle:git:check` checks for files to be commited
* `shuttle:git:pull` gives a pull from the origin repository
* `shuttle:git:push` gives a push to the origin repository
* `shuttle:bundle` install all the new gems
* `shuttle:spec` prepare and run all specs

#### Shuttle Stages

Stages are repositories for deploy, usually a repository hosted on [Heroku](http://heroku.com). You can configure multiple repositories representing different execution environments for their application, such as `staging` or `production`.

## How To

#### Integrate

Just run this to integrate your app:

    $ rake shuttle

#### Deploy

If you wish to deploy your app in `staging`, run this:

    $ rake shuttle[staging]
    
Or, deploy to `staging`, and then to `production`, run this:

    $ rake shuttle[staging:production]
    
You can deploy on how many repositories you want at once, as long as they are configured as Shuttle Stages.

**Note**: before deploy, it will integrate the app.

## Thanks

[Anna Cruz](http://twitter.com/yuizinha) for contributing in the README translation and revision.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
