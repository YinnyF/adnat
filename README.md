# Adnat (Ruby on Rails Challenge)

Ruby version: 2.7.4
Rails version: 6.1.4
Database: PostgreSQL
Testing: RSpec, Capybara
Other Gems: Devise

## Usage

First, clone this repository

Install dependencies using bundler:
```
bundle update
bundle install
```

Set up the databases:
```
bin/rails db:create
bin/rails db:migrate
```

To run tests:
```
bundle exec rspec
```

To start server at `http://localhost:3000/`:
```
bin/rails server
```
