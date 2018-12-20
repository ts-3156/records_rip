# Records, R.I.P.

This gem is a place to let deleted records rest in peace. :coffin:

Soft deletes are evil. _Blest be y man y spares thes stones. And curst be he y moves my bones._

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
User.tomb(name: 'Smith')
```

## Contributing

Everyone is encouraged to help improve this project. Here are a few ways you can help:

- [Report bugs](https://github.com/ts-3156/records_rip/issues)
- Fix bugs and [submit pull requests](https://github.com/ts-3156/records_rip/pulls)
- Write, clarify, or fix documentation
- Suggest or add new features
