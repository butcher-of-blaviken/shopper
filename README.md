# LCBO Shopper

## What does this Application do?

LCBO Shopper is an application that allows you to search LCBO's inventory and favorite
items that you like.

It is a Ruby On Rails application that uses PostgreSQL as the backing database and
SendGrid as an e-mail sender. It caches some responses from LCBO in different ways:
it caches search results in `Rails.cache` and caches product information in PostgreSQL.

## Rationale Behind Technologies

### Why Rails?

I chose Rails because it is quick to get a project up an running. It is a proven technology
that I have experience with, and has a lot of gems that provide fully baked solutions.

For logins, I chose to go with Devise rather than reinvent the wheel for signing up and logging in.
Devise supports sign ups, sign ins, and password resets, all of which are provided with the app.

### Why PostgreSQL?

For the database, PostgreSQL is another proven and stable RDBMS that is easily integrated with
ActiveRecord and, more importantly, Heroku. Heroku was used because it is trivial to deploy Rails
apps that are backed by PostgreSQL.

### Why in-memory `Rails.cache`?

In an ideal case we would have Couchbase as the caching layer but I chose to opt out and use the
in-memory Rails cache instead. The reason Couchbase is great for caching is because it is a persistent
cache that does not lose it's contents across application restarts, thereby mitigating the impacts
of "cold starts". However, setting this up on Heroku is by no means a trivial task (since setting it up
in general is by no means a trivial task) so I went the simple way due to time constraints.

In memory Rails cache also uses the LRU policy which is useful in this application.

### LCBO API Use Case

This application demonstrates a very simple use case of the LCBO API. We leverage it for searching and
we cache it's search results in the Rails in-memory cache for one hour, since it is unlikely to change during that
time.

We allow the user to favorite LCBO products and to view their history. We break down their history in a few ways,
either via a list of activities sorted in chronological order or a table in which we group by the product ID and the
action performed (i.e product viewed, product favourited, product unfavorited).

Another feature that could be implemented is using the LCBO Stores API and using the user's location to get
the stock of the item in a nearby store.

Another idea would be to build a sort of recommendation engine that recommends items to the user based on the items
that he has favorited. 

## Ruby version 
2.3.4

## Database creation
```bash
$ bundle exec rake db:create
$ bundle exec rake db:migrate
```

## Tests

```bash
$ bundle exec rake
```

## Environment Variables

This app uses SendGrid to send password reset e-mails to the user, and uses 
an LCBO API Key in order to access the LCBO API. Therefore, the environment variables
needed are:

* `SENDGRID_USERNAME`, `SENDGRID_PASSWORD` for SendGrid e-mail sending.
* `LCBO_API_KEY` for LCBO API calls.

## Deployment

```bash
$ heroku create
$ git add -A
$ git commit -m "c message"
$ git push heroku master
```
