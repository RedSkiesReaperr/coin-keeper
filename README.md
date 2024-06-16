# Coin Keeper

[![CircleCI](https://dl.circleci.com/status-badge/img/gh/RedSkiesReaperr/coin-keeper/tree/main.svg?style=svg)](https://dl.circleci.com/status-badge/redirect/gh/RedSkiesReaperr/coin-keeper/tree/main)
[![Ruby Style Guide](https://img.shields.io/badge/code_style-community-brightgreen.svg)](https://rubystyle.guide)
[![Maintainability](https://api.codeclimate.com/v1/badges/7468a36c5655928f3277/maintainability)](https://codeclimate.com/github/RedSkiesReaperr/coin-keeper/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/7468a36c5655928f3277/test_coverage)](https://codeclimate.com/github/RedSkiesReaperr/coin-keeper/test_coverage)

## Requirements

- Ruby 3.2.2
- Ruby on Rails 7.1.3
- PostgreSQL v16

## Getting started

```shell
$ rails db:create db:migrate db:seed
$ bin/dev
$ open http://localhost:3000
```

## Release

```shell
$ docker build -t redskiesreaperr/coinkeeper:x.x.x --platform linux/amd64 .
$ docker push redskiesreaperr/coinkeeper:x.x.x
```

## Dependencies

- [brakeman](https://github.com/presidentbeef/brakeman)
- [devise](https://github.com/heartcombo/devise)
- [factory_bot_rails](https://github.com/thoughtbot/factory_bot_rails)
- [faker](https://github.com/faker-ruby/faker/tree/main)
- [pagy](https://github.com/ddnexus/pagy)
- [rspec-rails](https://github.com/rspec/rspec-rails)
- [simplecov](https://github.com/simplecov-ruby/simplecov)
- [shoulda-matchers](https://github.com/thoughtbot/shoulda-matchers)