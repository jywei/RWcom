# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts "This seeds.rb will create 20 groups and 30 posts for each group!"

create_account = User.create([email: 'adam@example.com', password: '12345678', password_confirmation: '12345678', name: '測試用帳號'])

create_groups = for i in 1..20 do
                  Group.create!([title: "Group no.#{i}", description: "This is group No. #{i}", user_id: "1"])
                  GroupUser.create(group_id: i, user_id: 1)
                  for k in 1..30 do
                    Post.create!([group_id: "#{i}",content: "This is post No. #{k}", user_id: "1"])
                  end
                end
