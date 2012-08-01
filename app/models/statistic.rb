# encoding: utf-8
class Statistic
  include DataMapper::Resource

  property :id,           Serial
  property :type,         Enum[:weight, :blood_glucose]
  property :date,         Date
  property :value,        String
  
  belongs_to :user
end