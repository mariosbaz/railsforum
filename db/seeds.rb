# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Users
# Topics
User.order(:created_at).take(6).each do |user|
  (1..50).each do |i|
    user.topics.create!(name: "topic_#{i}")
  end
end

(1..50).each  do  |i| 
  User.last.posts.create!(topic_id: Topic.last.id, content: "#{i**i}")
end