# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

webmaster = User.create(
  first: "James", last: "Tunnell", email: "jamestunnell@gmail.com",
  password: "123456789")
webmaster.save
resp = webmaster.responsibilities.create(
  kind: "coordination", start_date: Date.today, end_date: Date.today + 20)
resp.save