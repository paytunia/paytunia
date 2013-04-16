Paytunia [![Build Status](https://secure.travis-ci.org/paytunia/paytunia.png?branch=master)](http://travis-ci.org/paytunia/paytunia)
=

The official Ruby gem to integrate your app with [Paytunia](https://paytunia.com).

## Installation

```
$ sudo gem install paytunia --pre
```

or add it to your `Gemfile`

```ruby
gem 'paytunia', '0.1.1alpha'
```

## Usage

### As a Ruby gem

### As a command-line executable

The Paytunia gem can be used directly from the command-line.

```
$ sudo gem install paytunia
$ paytunia get_ticker
{"high":24.79,"low":23.15, ... ,"currency":"EUR"}
```

## Authentication

### HTTP Basic

```ruby
connection = Paytunia.connect(basic_auth: { username: 'YOUR_USERNAME', password: 'YOUR_PASSWORD' })
connection.get_ledger
```

### OAuth2

Connect user the resource-owner credentials flow:

```ruby
connection = Paytunia.connect(oauth2: { username: 'YOUR_USERNAME', password: 'YOUR_PASSWORD' })
connection.get_ledger
```

Or pass an `access_token` directly:

```ruby
connection = Paytunia.connect(oauth2: { access_token: 'YOUR_TOKEN' })
connection.get_ledger
```
