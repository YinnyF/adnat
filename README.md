# Adnat (Ruby on Rails Challenge)

* Ruby version: 2.7.4
* Rails version: 6.1.4
* Database: PostgreSQL
* Testing: RSpec, Capybara
* Other Gems: Devise

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

To run feature tests only:
```
bundle exec rspec spec/features
```

To run unit tests only:
```
bundle exec rspec spec/models
```

To start server at `http://localhost:3000/`:
```
bin/rails server
```

## Entity-relationship diagram

![](https://i.imgur.com/w1YzNY6.png)

## Specification

- ✅  An unauthenticated user should first be prompted to log in, sign up, or reset their password
- ✅  Users have names, so "Name" should be a field on your sign up page
- ✅  After signing up, users should be prompted to join/create an organisation
- ✅  Users should be able to edit all organisations (i.e. their names and their hourly rates)
- ✅  Once a user has joined an organisation, the home page should include 'view shifts', 'edit', 'leave' actions for the organisation
- ✅  Leaving an organisation should return the user to the state they are in just after they sign up
- ✅  Departed user's shifts should be deleted
- ✅  Shift page should show all shifts that belong to the user and their fellow employees
- ✅  Shifts are ordered from newest to oldest
- ✅  Breaks are considered unpaid and are thus subtracted from shift length to determine hours worked 
- ✅  Shift costs are determined per `shift cost = hours worked * organisation hourly rate`
- ✅  Creating a new shift for the user that is logged in (inside the table)
- ✅  Shift date and start time are stored in the same database column as `DateTime`

### Optional exercises
- ✅  (1) User details: Allow users to change their own name, email address, or password
- ✅  (2) Modifying/Deleting shifts: Allow users to modify or delete their own shifts
- ✅  (5) Overnight shifts
- ✅  (6) Penalty rates on Sundays
- ✅  (9) Functional or Unit tests - **attempted but not exhaustive**

- ⬜️  (3) Departed Employee Shift Storage
- ⬜️  (4) Filtering shifts
- ⬜️  (7) Multiple breaks
- ⬜️  (8) Multiple organisations
- ⬜️  (10) JavaScript enhancements

## Overview of my approach
* Set up Rails project
* Set up Devise User model (I did not set up mailers or admin accounts)
* Implemented User log in, sign up, sign out, edit features in the views
* Added a custom field `name` to the Devise user model
* Wrote feature tests and unit tests from this point (I found it was especially helpful when refactoring)
* Created some web helpers for testing
* Created `Organisation` model with model associations and validations
* Created `Membership` model that handles user memberships to organisations, added associations and validations
* Implemented the features for organisations as described in the spec
* Created `Shift` scaffold, added associations and validations
* Adjusted the `Shift` model to display shifts from the database in the required format (unit tested)
* Implemented the shift features as described in the spec, the create shift form appears in the table too
* Set a validation on `break_length` to be between 0 and 720 minutes (12 hours)
* Set defaults and 15 min increments for shifts for better user experience
* Worked on some more optional features
* Tidy up and refactoring

## TODO/Improvements
* significant chunk of logic for creating and updating shifts is currently sitting in `ShiftsController` which is not ideal, unsure how to delegate this to the model
* look into FactoryBot gem which seems super popular online
* seek feedback for: deleting shifts when a user leaves an org
* seek feedback for: deleting shifts when an org is deleted
* any feedback :)

Thanks! Any questions please let me know!