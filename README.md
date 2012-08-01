user_goals
==========

This is a prototype schema for a user / goals system. For demonstration purposes, this uses Sinatra to expose the various underlying data models via JSON routes.

Setup
-----

* Create a local MySQL database called user_goals_development and a user with full permission to this schema called user_goals
* `$ gem install bundler ; bundle install`
* `$ bundle exec thin start`
* Open http://0.0.0.0:3000/path/to/resource.json to test the JSON routes.

Routes
------

* `/meals.json` => all meal categories
* `/activities.json` => all activity categories
* `/food/:id.json` => all foods within the given category (meal)
* `/activity/:id.json` => all activities within the given category
* `/user/:id.json` => a specified user's details, including any goals within their plan

Caveats
-------

For simplicity's sake, this prototype doesn't attempt to deal with authentication (although the user model does have properties for auth in this example). This should be handled with a session token passed back as part of an authentication step, and stored locally.

TODO
----

Posted routes:

* Register a user
* Authenticate a user
* Reset a password
* Add a goal to a user
* Update a goal's status (change priority, mark as done)
* Update a user's reward
* Set a reminder