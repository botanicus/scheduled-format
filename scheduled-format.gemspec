#!/usr/bin/env gem build
# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name        = 'scheduled-format'
  s.version     = '0.0.1'
  s.authors     = ['James C Russell']
  s.email       = 'james@101ideas.cz'
  s.homepage    = 'http://github.com/botanicus/scheduled-format'
  s.summary     = ''
  s.description = "#{s.summary}."
  s.license     = 'MIT'
  s.metadata['yard.run'] = 'yri' # use 'yard' to build full HTML docs.

  s.files = Dir.glob('lib/**/*.rb') + ['README.md', '.yardopts']

  s.add_runtime_dependency('commonjs_modules', ['~> 0.0'])
  s.add_runtime_dependency('parslet', ['~> 1.8'])
end
