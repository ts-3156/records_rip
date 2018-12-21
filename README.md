# Records, R.I.P.

This gem is a place to let deleted records rest in peace. :coffin:

Soft deletes are evil. __Blest be y man y spares thes stones. And curst be he y moves my bones.__

## Getting Started

Add this line to your application’s Gemfile:

```ruby
gem 'records_rip'
```

Add `rest_in_peace` to the models you want to visit the tomb.

```ruby
class User < ApplicationRecord
  rest_in_place
end
```

#### Scopes

You can perform WHERE queries for `tombs#epitaph` based on attributes:

```ruby
user = User.create(name: 'Smith')
user.destroy

User.tomb(name: 'Smith').to_a
# => [#<RecordsRip::Tomb id: 1, item_type: "User", item_id: 1, epitaph: "{\"id\"=>1, \"name\"=>\"Smith\"}">]
```

#### Change serialization method

```ruby
class User < ApplicationRecord
  rest_in_place {|record| Hash[record.attributes.map {|k, v| [k, "Great #{v}"]}] }
end

user = User.create(name: 'Smith')
user.destroy

User.tomb(name: 'Great Smith').to_a
# => [#<RecordsRip::Tomb id: 1, item_type: "User", item_id: 1, epitaph: "{\"id\"=>1, \"name\"=>\"Great Smith\"}">]
```

## Contributing

Everyone is encouraged to help improve this project. Here are a few ways you can help:

- [Report bugs](https://github.com/ts-3156/records_rip/issues)
- Fix bugs and [submit pull requests](https://github.com/ts-3156/records_rip/pulls)
- Write, clarify, or fix documentation
- Suggest or add new features
