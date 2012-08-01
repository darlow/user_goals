require './application'

Category.import_from_yaml

user = User.generate
user.plans.push Goal.get(1)
user.plans.push Goal.get(2)
user.plans.push Goal.get(3)
user.plans.push Goal.get(4)
user.plans.push Goal.get(5)
user.save

puts({
  :id         => user.id,
  :name       => user.name,
  :email      => user.email,
  :avatar     => user.avatar,
  :reminder   => user.reminder,
  :repeat     => user.repeat,
  :goals      => user.goals,
  :statistics => user.statistics
}.to_json)