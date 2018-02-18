begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end
Bundler::GemHelper.install_tasks

require 'engine_cart/rake_task'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

task ci: ['engine_cart:generate'] do
  ENV['environment'] = 'test'
  Rake::Task['spec'].invoke
end

task default: [:ci]
