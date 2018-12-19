# Records, R.I.P.

This is a gem to let deleted records rest in peace. :coffin:

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

```ruby
User.tomb.where(name: 'Smith')
```

## Contributing

Everyone is encouraged to help improve this project. Here are a few ways you can help:

- [Report bugs](https://github.com/ts-3156/records_rip/issues)
- Fix bugs and [submit pull requests](https://github.com/ts-3156/records_rip/pulls)
- Write, clarify, or fix documentation
- Suggest or add new features
