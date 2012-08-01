# encoding: utf-8
require 'yaml'

class Category
  include DataMapper::Resource

  property :id,     Serial
  property :type,   Enum[:food, :activity]
  property :name,   String
  property :tip,    String, :length => 255
  
  has n, :items
  
  def self.import_from_yaml
    yaml = YAML.load(File.new("app/data/categories.yml"))
    
    yaml.each do |c|
      category = Category.new
      
      category.type = c[:type]
      category.name = c[:name]
      category.tip  = c[:tip]
      category.save
      
      c[:items].each do |i|
        item = Item.new
        
        item.name     = i[:name]
        item.image    = i[:image]
        item.category = category
        
        item.save
        
        i[:goals].each do |g|
          goal = Goal.new

          goal.title       = g[:title]
          goal.description = g[:description] if g.has_key? :description
          goal.item        = item

          goal.save          
        end

      end
    end
  end
  
end

# get all meal categories
get '/meals.json' do
  content_type :json
  
  Category.all(:type => :food).to_json
end

# get all activity categories
get '/activities.json' do
  content_type :json
  
  Category.all(:type => :activity).to_json
end