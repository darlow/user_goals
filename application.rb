require 'rubygems'
require 'bundler'
require 'json'
Bundler.require

configure :development do
  DataMapper.setup :default, "sqlite::memory:"
end

Dir[File.join(File.dirname(__FILE__), 'app/**/*.rb')].sort.each { |f| require f }

DataMapper.finalize
DataMapper.auto_upgrade!

get '/init' do
  unless Category.any?
    Category.import_from_yaml
    10.times { User.generate }
    "Initialised"
  else
    "Previously initialised"
  end
end