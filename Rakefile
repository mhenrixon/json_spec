# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'cucumber/rake/task'
require 'reek/rake/task'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

Dir.glob("#{File.expand_path(__dir__)}/lib/tasks/**/*.rake").each { |f| import f }

Reek::Rake::Task.new(:reek) do |t|
  t.name          = 'reek'
  t.config_file   = '.reek.yml'
  t.source_files  = '.'
  t.reek_opts     = %w[
    --line-numbers
    --color
    --documentation
    --progress
    --single-line
    --sort-by smelliness
  ].join(' ')
  t.fail_on_error = true
  t.verbose       = true
end

def changed_files(pedantry)
  `git diff-tree --no-commit-id --name-only -r HEAD~#{pedantry} HEAD`
    .split("\n").select { |f| f.match(/(\.rb\z)|Rakefile/) && File.exist?(f) && !f.match(/db/) }
end

RuboCop::RakeTask.new(:rubocop) do |task|
  # task.patterns = changed_files(5)
  task.options = %w[-DEP --require fuubar --format fuubar]
end

desc 'Validate ruby style'
task style: %i[reek rubocop]

RSpec::Core::RakeTask.new(:rspec) do |t|
  t.rspec_opts = '--require fuubar --format Fuubar --format Nc'
end

Cucumber::Rake::Task.new(:cucumber) do |task|
  task.cucumber_opts = '--tags ~@tag'
end

Cucumber::Rake::Task.new(:negative_cucumber) do |task|
  task.cucumber_opts = '--tags @fail --wip'
end

desc 'Execute all tests'
task test: %i[rspec cucumber negative_cucumber]
task default: :test
