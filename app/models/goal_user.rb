# encoding: utf-8
class GoalUser
  include DataMapper::Resource

  property :id,       Serial
  property :priority, Boolean, :default => false
  property :done,     Boolean, :default => false
  
  belongs_to :goal
  belongs_to :user

end