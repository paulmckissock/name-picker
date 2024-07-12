# db/seeds.rb

# Clear existing data
Participant.destroy_all
Result.destroy_all
Wheel.destroy_all
User.destroy_all

# Create Users
users = User.create!([
  {username: "user1", password: "password1", password_confirmation: "password1"},
  {username: "user2", password: "password2", password_confirmation: "password2"},
  {username: "user3", password: "password3", password_confirmation: "password3"}
])

# Create Wheels
wheels = Wheel.create!([
  {title: "Wheel 1", user: users.first},
  {title: "Wheel 2", user: users.second},
  {title: "Wheel 3", user: users.third}
])

# Create Participants
participants = Participant.create!([
  {name: "Participant 1", wheel: wheels.first},
  {name: "Participant 2", wheel: wheels.second},
  {name: "Participant 3", wheel: wheels.third}
])

# Create Results
Result.create!([
  {participant: participants.first, user: users.first, wheel: wheels.first},
  {participant: participants.second, user: users.second, wheel: wheels.second},
  {participant: participants.third, user: users.third, wheel: wheels.third}
])

puts "Seeding complete!"
