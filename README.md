# Oversee

Plug & play content management system (CMS) for Rails applications. Some may call it an admin dashboard too.

<a href="https://rubygems.org/gems/oversee">
  <img alt="Oversee GEM Version" src="https://img.shields.io/gem/v/oversee?color=10b981&include_prereleases&logo=ruby&logoColor=f43f5e">
</a>

<a href="https://rubygems.org/gems/oversee">
  <img alt="Oversee GEM Version" src="https://img.shields.io/gem/dt/oversee?color=10b981&include_prereleases&logo=ruby&logoColor=f43f5e">
</a>

---

### Features

- Minimal, if any, configuration needed
- Tailored and pleasant user interface
- Geared for performance

---

![Oversee Screenshot](docs/images/screenshot.png)

Developed by [Primevise](https://primevise.com)

> [!NOTE]
> Oversee is still rather incomplete and only has the very basic features. It might significantly change and break things before a stable release.

## Installation

#### Add gem

Simply add the gem to your Gemfile by running the following command

```bash
$ bundle add oversee
```

> [!TIP]
> Currently, we don't release new gem versions too often due to the fragile nature of the gem. However, you can use the edge version of the gem by pointing directly to the git repository.
>
> ```ruby
> gem "oversee", git: "https://github.com/primevise/oversee", branch: :main
> ```

---

#### Mount it on your application

After you have the gem installed, you can then mount the engine in your `config/routes.rb`:

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
- [Hansa](https://hansahq.com)
- [No Logo X](https://nologox.com)
- [Release Server](https://releaseserver.com)
- [College Life Work](https://work.collegelife.co)

Do you use Oversee in your project? Let us know!

## Contributing

TBA

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
