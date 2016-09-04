# Trelloist

Create trello checklists from command line

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'trelloist'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install trelloist

## Usage

```
→ ./trelloist boards
["Board1", "5125ee02548258123"]
["Board2", "5126926862a123122"]
..


./trelloist cards -b 5126926862a123122
["Card1", "5126123123123"]
["Card2", "512618df6f273"]
...

curl -s http://twohosers.com/episodes/ | pup 'div.entry-content ul li a text{}' | xargs -0 ./trelloist create -c 5126123123123 -n 'two hosers podcast'

"ADDING 261- Beware The Gimmick!"
"ADDING 260- Five Years"
"ADDING 259- The Xmas Special 5"
"ADDING 258- Don We Now Our…"
"ADDING 257- Gift Ideas"
....
"ADDING 3- Aperture"
"ADDING 2- ISO"
"ADDING 1- Meet The Hosers"
"Added new checklist two hosers podcast to card Card2 with 265 items"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/trelloist.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
