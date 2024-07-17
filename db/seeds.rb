Result.destroy_all
Participant.destroy_all
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
  {name: "Paul", wheel: wheels.first},
  {name: "Ciel", wheel: wheels.first},
  {name: "Faye", wheel: wheels.first},
  {name: "Aubrey", wheel: wheels.first},
  {name: "Nathan", wheel: wheels.first},
  {name: "Lauren", wheel: wheels.first},
  {name: "Participant 2", wheel: wheels.second},
  {name: "Participant 3", wheel: wheels.third}
])

Result.create!([
  {participant: participants.first, participant_name: participants.first.name, user: users.first, wheel: wheels.first},
  {participant: participants.first, participant_name: participants.first.name, user: users.first, wheel: wheels.first},
  {participant: participants.second, participant_name: participants.second.name, user: users.first, wheel: wheels.first},
  {participant: participants.second, participant_name: participants.second.name, user: users.first, wheel: wheels.first}
])

puts "Seeding complete!"
