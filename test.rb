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

Category.import_from_yaml

user = User.generate

user.plans.create :goal => Goal.get(1)
user.plans.create :goal => Goal.get(2)
user.plans.create :goal => Goal.get(3)
user.plans.create :goal => Goal.get(4)
user.plans.create :goal => Goal.get(5)

h = {
  :id         => user.id,
  :name       => user.name,
  :email      => user.email,
  :avatar     => user.avatar,
  :reward     => user.reward,
  :reminder   => user.reminder,
  :repeat     => user.repeat,
  :goals      => user.plans.map {|p|
    {
      :plan_id     => p.id, 
      :goal_id     => p.goal.id, 
      :title       => p.goal.title, 
      :description => p.goal.description, 
      :done        => p.done, 
      :priority    => p.priority
    }
  },
  :statistics => user.statistics
}


puts(h.to_json)