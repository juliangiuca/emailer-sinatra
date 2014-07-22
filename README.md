# Emailer-Sinatra
This app is the precursor to [Emailer](https://github.com/juliangiuca/emailer). This is a Sinatra (Ruby) and AngularJS app.  

**This project is deprecated**. I found there were so many pieces of Rails being added to this project, and that it was easier
to restart the project in Rails.

## Setup
```
bundle install
rake db:create
rake db:migrate

```
You will also need SMTP, redis, tracking pixel url, and database credentials to put into config/settings.json

## Starting it up

```
rackup
```

## Debugging
You can use:
```
ruby ./console
```
to get a full environment console (like the Rails console) up and running.

## Deploying
```
cap prod deploy
```

## License
MIT License
