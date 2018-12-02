# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users_h = 200.times.map do {
  username: FFaker::Internet.user_name[0..25],
  fullname: FFaker::Internet.user_name[0..25],
  email: FFaker::Internet.safe_email ,
  password: '12345'
}
end

User.create! username: 'test', fullname: 'test', email: 'test@test.com', password: '12345'
User.create! users_h

users = User.all 

team_h = 100.times.map do {
	title: FFaker::HipsterIpsum.paragraph,
  body: FFaker::HipsterIpsum.paragraphs,
  summary: FFaker::HipsterIpsum.paragraph,
  user: users.sample
}
end

Team.create! team_h
