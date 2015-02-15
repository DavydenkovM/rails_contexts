# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

ActiveRecord::Base.transaction do
  users = User.create([
    {email: 'test@test.ru', name: 'User1', state: 'initial', type: 'RegularUser', password: '123123123', password_confirmation: '123123123'},
    {email: 'test2@test.ru', name: 'User2', state: 'initial', type: 'RegularUser', password: '123123123', password_confirmation: '112323123'},
    {email: 'test3@test.ru', name: 'User3', state: 'initial', type: 'RegularUser', password: '123123123', password_confirmation: '123123123'},
    {email: 'admin@test.ru', name: 'Admin1', state: 'initial', type: 'AdminUser', password: '123123123', password_confirmation: '123123123'},
  ])

  accounts = Account.create([
    {balance: 10000, bonus_points: 0, user_id: 1},
    {balance: 10000, bonus_points: 0, user_id: 1},
    {balance: 10000, bonus_points: 0, user_id: 2},
    {balance: 10000, bonus_points: 0, user_id: 3},
  ])

end
