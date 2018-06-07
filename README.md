# About

[![Gem version][GV img]][Gem version]
[![Build status][BS img]][Build status]
[![Coverage status][CS img]][Coverage status]
[![CodeClimate status][CC img]][CodeClimate status]
[![YARD documentation][YD img]][YARD documentation]

# API

```ruby
require 'import'

simple_format = import('simple-format')
simple_format.parse(File.read('tasks.todo'))
```

# Format

This format is used to store **scheduled tasks**: tasks that will be done later
or in a certain context.

```
Tomorrow
- Buy milk. #errands
- [9:20] Call with Mike.

Prague
- Pick up my shoes. #errands
```

# Currently unsupported

- **Labels**. Labels allow us to match tasks with _named_ time frames.
  See [#8](https://github.com/botanicus/now-task-manager/issues/8).

```
- ADM: Catch up with Eva.
```

# Intentionally unsupported

- **Comments**. I want to keep the format simple and the task file small.
  Every time there was something like comments, the file bloated uncontrollably.
- **Task formatting**. Task is a string, it doesn't recognise any structures within.
  Therefore, anything you can fit in to a line will be the task body. So you can
  put anything that {Pomodoro::Formats::Today} supports such as scheduled times
  and tags.

_For more details about the format see
{https://github.com/botanicus/scheduled-format/blob/master/spec/scheduled-format/parser/parser_spec.rb parser_spec.rb}._

[Gem version]: https://rubygems.org/gems/scheduled-format
[Build status]: https://travis-ci.org/botanicus/scheduled-format
[Coverage status]: https://coveralls.io/github/botanicus/scheduled-format
[CodeClimate status]: https://codeclimate.com/github/botanicus/scheduled-format/maintainability
[YARD documentation]: http://www.rubydoc.info/github/botanicus/scheduled-format/master

[GV img]: https://badge.fury.io/rb/scheduled-format.svg
[BS img]: https://travis-ci.org/botanicus/scheduled-format.svg?branch=master
[CS img]: https://img.shields.io/coveralls/botanicus/scheduled-format.svg
[CC img]: https://api.codeclimate.com/v1/badges/a99a88d28ad37a79dbf6/maintainability
[YD img]: http://img.shields.io/badge/yard-docs-blue.svg
