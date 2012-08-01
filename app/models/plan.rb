# encoding: utf-8
class Plan
  include DataMapper::Resource

  property :id,       Serial
  property :priority, Boolean, :default => false
  property :done,     Boolean, :default => false
  
  belongs_to :user
  belongs_to :goal

end