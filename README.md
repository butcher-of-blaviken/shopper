# LCBO Shopper

## What does this Application do?

LCBO Shopper is an application that allows you to search LCBO's inventory and favorite
items that you like.

It is a Ruby On Rails application that uses PostgreSQL as the backing database and
SendGrid as an e-mail sender. It caches some responses from LCBO in different ways:
it caches search results in `Rails.cache` and caches product information in PostgreSQL.

### Other feature possibilities

We have not used the LCBO API to its full extent. The next step would be to get
the user's location and use that to show them whether the item they are viewing is
in stock in stores close to them.

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
