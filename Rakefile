# frozen_string_literal: true

default = []
begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
  default << :spec
rescue LoadError # rubocop:disable Lint/HandleExceptions
end

begin
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new
  default << :rubocop
rescue LoadError # rubocop:disable Lint/HandleExceptions
end

task default: default
