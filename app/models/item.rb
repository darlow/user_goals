# encoding: utf-8
class Item
  include DataMapper::Resource

  property :id,     Serial
  property :name,   String
  property :image,  String
  
  belongs_to :category
end

# get all foods belonging to the meal category with key of ‘id’
get '/food/:id.json' do |id|
  content_type :json
  
  category = Category.get(id)
  Item.all(:category => category).to_json
end

# get all activities belonging to the category with key of ‘id’
get '/activity/:id.json' do |id|
  content_type :json
  
  category = Category.get(id)
  Item.all(:category => category).to_json
end
