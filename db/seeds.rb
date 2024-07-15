Participant.destroy_all
Result.destroy_all
Wheel.destroy_all
User.destroy_all

users = User.create!([
  {username: "user1", email: "user1@example.com", password: "password", password_confirmation: "password"},
  {username: "user2", email: "user2@example.com", password: "password", password_confirmation: "password"},
  {username: "user3", email: "user3@example.com", password: "password", password_confirmation: "password"}
])

wheels = Wheel.create!([
  {title: "Wheel 1", user: users.first},
  {title: "Wheel 2", user: users.second},
  {title: "Wheel 3", user: users.third}
])

participants = Participant.create!([
  {name: "Participant 1", wheel: wheels.first},
  {name: "Participant 2", wheel: wheels.second},
  {name: "Participant 3", wheel: wheels.third}
])

Result.create!([
  {participant: participants.first, user: users.first, wheel: wheels.first},
  {participant: participants.second, user: users.second, wheel: wheels.second},
  {participant: participants.third, user: users.third, wheel: wheels.third}
])

puts "Seeding complete!"
