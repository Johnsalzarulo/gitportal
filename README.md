# Gitportal (In Development)

This is actually kind of working

You just need to include the gem (locally for now)

then you just have to add this to your application controller:

````
helper Gitportal::Engine.helpers
```

Then you just have to add this to your routes:
````

Rails.application.routes.draw do
mount Gitportal::Engine => "/gitportal"
end

````
## Usage
TODO

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'gitportal'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install gitportal
```

## Contributing
TODO

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
````
