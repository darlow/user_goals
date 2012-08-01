require 'rubygems'
require 'bundler'
require 'json'
Bundler.require

configure :development do
  DataMapper.setup :default, YAML.load(File.new("app/config/database.yml"))[:development]
end

Dir[File.join(File.dirname(__FILE__), 'app/**/*.rb')].sort.each { |f| require f }

DataMapper.finalize
DataMapper.auto_upgrade!

Category.import_from_yaml
10.times { User.generate }