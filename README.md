![CI](https://github.com/sebasjimenez10/weather_app/actions/workflows/ci.yml/badge.svg?branch=main)

# README

## Weather App

A simple Ruby On Rails application that provides current weather information for a given address.

## Ruby version

- Ruby 3.3.0

## System dependencies

- Bundler
- WeatherAPI (https://www.weatherapi.com/docs)

## Configuration

1. Clone the repository.
2. Run `bundle install` to install dependencies.
3. Run `bundle exec rails db:create` to create the db.
4. Make sure your rails master key is set (config/master.key)
5. Set your WeatherAPI API key inside the credentials file:
   5.1 Run `EDITOR="code --wait" be rails credentials:edit`.
   5.2 Make sure it follows this structure:

   ```yaml
   development:
     weather_api_key: <...>

   test:
     weather_api_key: <...>

   production:
     weather_api_key: <...>
   ```

6. For development purposes the cache store is set to :memory_store. In production mode it runs solid_cache_store.

NOTE: There are no db-backed models but rails will require the existence of the db.

## Database creation

No database required.

## Database initialization

Not applicable.

## How to run the test suite

Run `bundle exec rspec` to execute the test suite.

### Code coverage

If you would like to get code coverage statistics run `COVERAGE=true be rspec spec`, and then open the results with by running `open coverage/index.html`.

## Services

- Uses WeatherAPI API for weather data.
