# encoding: utf-8
class Goal
  include DataMapper::Resource

  property :id,           Serial
  property :title,        String, :length => 255
  property :description,  String, :length => 255
  
  belongs_to :item
  has n, :plans
end

# get all goals belonging to the food with key of ‘id’
get '/food/goals/:id.json' do |id|
  content_type :json
  
  food = Item.get(id)
  Goal.all(:item => food).to_json
end

# get all goals belonging to the activity with key of ‘id’
get '/activity/goals/:id.json' do |id|
  content_type :json
  
  activity = Item.get(id)
  Goal.all(:item => activity).to_json
end
