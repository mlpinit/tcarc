# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(email: "marius@mlpinit.com", username: "mlpinit", password: "12341234", password_confirmation: "12341234")
User.create!(email: "tammy@mlpinit.com", username: "smurfik", password: "12341234", password_confirmation: "12341234")
User.create!(email: "test1@mlpinit.com", username: "test1", password: "12341234", password_confirmation: "12341234")
User.create!(email: "test2@mlpinit.com", username: "test2", password: "12341234", password_confirmation: "12341234")
User.create!(email: "frank@mlpinit.com", username: "frank", password: "12341234", password_confirmation: "12341234")
