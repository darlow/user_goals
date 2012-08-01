require 'rubygems'
require 'bundler'
require 'json'
require 'date'

Bundler.require

configure :development do
  DataMapper.setup :default, YAML.load(File.new("app/config/database.yml"))[:development]
end

Dir[File.join(File.dirname(__FILE__), 'app/**/*.rb')].sort.each { |f| require f }

DataMapper.finalize
DataMapper.auto_upgrade!

get '/init' do
  unless Category.any?
    Category.import_from_yaml
    10.times { User.generate }
    
    user = User.first
    
    user.plans.create :goal => Goal.get(1)
    user.plans.create :goal => Goal.get(2)
    user.plans.create :goal => Goal.get(3)
    user.plans.create :goal => Goal.get(4)
    user.plans.create :goal => Goal.get(5)
    
    today = DateTime.now
    
    user.statistics.create :type => :weight, :date => today, :value => 153
    user.statistics.create :type => :weight, :date => today - 7, :value => 160
    user.statistics.create :type => :weight, :date => today - 14, :value => 155
    user.statistics.create :type => :weight, :date => today - 21, :value => 159
    user.statistics.create :type => :weight, :date => today - 28, :value => 165
    
    "Initialised"
  else
    "Previously initialised"
  end
end