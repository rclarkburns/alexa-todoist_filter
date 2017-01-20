# Alexa::TodoistFilter

A command line tool for moving Alexa todos in Todoist into a user specified project.

This allows for easily sharing between Todoist accounts. 

* Setup a Todoist account specifically for Alexa. 
* Create a project in that account and share it with each individuals Todoist account. 
* Run this handy bit of code which will move any todo in your Inbox labeled with 'Alexa' (default behavior) to the 
project you specify
* Now you can say 'Alexa, add [IMPORTANT THING] to my todo list' and everyone subscribed to the Todoist project will 
automatically have access to that todo. 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'alexa-todoist_filter'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install alexa-todoist_filter

## Usage

Help
```
bundle exec ./bin/alexa-todoist_filter help
```

Move Alexa added todos
```
bundle exec ./bin/alexa-todoist_filter inbox_todos API_TOKEN PROJECT_NAME
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rclarkburns/alexa-todoist_filter.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

