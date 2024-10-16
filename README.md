[![Gem Version](https://badge.fury.io/rb/oversee.svg)](https://badge.fury.io/rb/oversee)

# 👓 Oversee

Plug & play admin dashboard for Rails applications.

![Oversee Screenshot](docs/images/screenshot.png)

Developed by [Primevise](https://primevise.com)

> [!NOTE]
> Oversee is still rather incomplete and only has the very basic features. It might significantly change and break things before a stable release.

## Installation

```bash
$ bundle add oversee
```

and then mount the engine in your `config/routes.rb`:

```ruby
Rails.application.routes.draw do
  mount Oversee::Engine => "/oversee"
end
```

Ideally, you'd want to limit access to the dashboard to only authorized users.




## Notable mentions

This gem would not be possible without the work of others. A big thank you goes to these projects:

- [madmin](https://github.com/excid3/madmin)
- [Avo](https://github.com/avo-hq/avo)
- [Iconoir](https://github.com/iconoir-icons/iconoir)

## Who uses Oversee?

- [Mintis](https://mintis.app)
- [No Logo X](https://nologox.com)
- [Release Server](https://releaseserver.com)
- [College Life Work](https://work.collegelife.co)

Do you use Oversee in your project? Let us know!

## Contributing

TBA

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
