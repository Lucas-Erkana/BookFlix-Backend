User.create(full_name: "Lucas", role: "admin", email: "admin@gmail.com", password: "123456")
users = ["Lucas", "Kevin", "Saba", "Samson", "Faranosh", "Jenny"]
users.each do |user|
    User.create(full_name: user, role: "user", email: user+"@gmail.com", password: "123456")
end
