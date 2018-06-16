# Thingamajig

Thingamajig offers an OOPy API to interact with a local [Things 3 Mac app](https://culturedcode.com/things/) instance. Use it to create and manipulate todos and more.

## Usage

This README is severaly lacking in instructions. Here's some sample code that might give you an intuitive feel of how to use it:

```ruby
  # List all projects
  Thingamajig.new.projects.each do |project|
    puts "Found project #{project.name} with #{project.todos.count} todos"
  end

  # Find a project
  project = Thingamajig::Project.find_by(name: "Home")

  # List all todos (that have not been logged yet)
  project.todos.each do |todo|
    puts "Todo: #{todo.name}"
    puts todo.notes
  end

  # List all "active" todos (i.e. showing up in Today)
  project.todos(Thingamajig::Todo.predicate_active).each do |todo|
    # Reschedule them to tomorrow
    todo.activation_date = 1.day.from_now
  end

  # Create new Todo with a name and some notes
  todo = project.create_todo!("Fix drainage", "Is it just clogged, or should we replace the plumbing?")

  # Schedule it for a future date
  todo.activation_date = 5.days.from_now

  # Show it in the GUI
  todo.show

  # Or complete it
  todo.complete!

  # List all projects under the Area named "Work"
  Thingamajig::Area.find_by(name: "Work").projects.flat_map do |project|
    # For each project, get the todos that are active and have status "open" (not completed or cancelled)
    project.todos(Thingamajig::Todo.predicate_active.and(Thingamajig::Todo.predicate_open))
  end
```

If you're tired of typing "Thingamajig" out in full, feel free to alias it:

```ruby
Things = Thingamajig
```

I do. Sadly RubyGems is littered with Things-related gems that haven't been updated in 8 years and don't work with Things 2, let alone Things 3, but they're still hogging all the best names. `things`, `thingies`, `things-client`, `things-rb`, ... even `thingamabob` is taken.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'thingamajig'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install thingamajig

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/dv/thingamajig/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
