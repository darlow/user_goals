# encoding: utf-8

class User
  include DataMapper::Resource

  property :id,           Serial
  property :name,         String
  property :email,        String
  property :avatar,       String # path to avatar image
  property :reminder,     Date
  property :repeat,       Enum[:none, :daily, :weekly, :monthly]
  
  has n, :goals, :through => Resource
  has n, :statistics
  
  is :authenticatable
end

User.fixture {{
  :name                  => Randgen.name,
  :email                 => "#{/\w+/.gen}@#{/\w+/.gen}.#{/co.uk|com|net|org/.gen}",
  :password              => (password = /\w+/.gen),
  :password_confirmation => password
}}

get '/user/:id.json' do |id|
  content_type :json
  
  user = User.get(id)
  
  {
    :id         => user.id,
    :name       => user.name,
    :email      => user.email,
    :avatar     => user.avatar,
    :reminder   => user.reminder,
    :repeat     => user.repeat,
    :goals      => user.goals,
    :statistics => user.statistics
  }.to_json
end