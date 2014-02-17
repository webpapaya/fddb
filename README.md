# fddb.info

This gem is an implementation of the fddb.info API to get food related information.

## Usage

Create an instance of
```
   fddb = FDDB::API.new <<'your api key'>>
   item = fddb.get_item <<item_id>>
   search = fddb.search <<search_query>>

   item.get_ingredients  # returns all ingredients of the item
   search.get_ingredients # returns ingredients of all items
```


## Installation

Add this line to your application's Gemfile:

    gem 'fddb'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fddb

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
