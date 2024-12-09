puts "> OVERSEE | SEEDING DUMMY APP"


puts ">> Creating users"
password_digest = BCrypt::Password.create("password")
users = 96.times.map { |i|
  {
    full_name: FFaker::Name.name,
    email_address: "test+#{i + 1}@primevise.com",
    birthday: Time.current,
    is_verified: [true, false].sample,
    password_digest:,
    metadata: {
      dark_mode: [true, false].sample,
    },
  }
}
User.insert_all(users)
