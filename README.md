# Heroku Buildpack Nginx

This buildpack will work out-of-the-box with nginx. It installs nginx, add authentication and some other cool stuff. Inspired by and copied from [tonycoco/heroku-buildpack-ember-cli](https://github.com/tonycoco/heroku-buildpack-ember-cli).

By default it will serve the website from the `html` directory. You can easily overwrite that in the custom nginx config file.

## Usage

Creating a new Heroku instance from the application's parent directory:

    $ heroku create --buildpack https://github.com/socialshop/heroku-buildpack-nginx.git

    $ git push heroku master
    ...
    -----> Heroku receiving push
    -----> Fetching custom buildpack
    ...

Or add buildback to existing Heroku app

    $ heroku config:add BUILDPACK_URL=https://github.com/socialshop/heroku-buildpack-nginx.git

## Configuration

### Variables

You can set a few different environment variables to turn on features in this buildpack.

#### Nginx Workers

Set the number of workers for Nginx (Default: `4`):

    heroku config:set NGINX_WORKERS=4

#### Authentication

Have a staging server? Want to protect it with authentication? When `BASIC_AUTH_USER` and `BASIC_AUTH_PASSWORD` are set basic authentication will be activated:

    heroku config:set BASIC_AUTH_USER=EXAMPLE_USER
    heroku config:set BASIC_AUTH_PASSWORD=EXAMPLE_PASSWORD

*Be sure to use `https` when you set this up for added security.*

#### Force HTTPS/SSL

For most Ember applications that make any kind of authenticated requests (sending an auth token with a request for example), HTTPS should be used. Enable this feature in nginx by setting `FORCE_HTTPS`.

    heroku config:set FORCE_HTTPS=true

#### Before and After Hooks

You can run your own scripts by creating `after_hook.sh` or `before_hook.sh` files (or both) in your app's `hooks` directory:

    mkdir hooks
    cd hooks
    touch after_hook.sh
    touch before_hook.sh

### Custom Nginx

Need to make a custom nginx configuration change? No problem. In your application, add a `conf/nginx.conf.erb` file. You can copy the existing configuration file in this repo and make your changes to it.

### Useful documentation

https://devcenter.heroku.com/articles/buildpack-api
