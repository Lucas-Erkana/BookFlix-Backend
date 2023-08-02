cities = ["Windhoek", "Nairobi", "Punjab", 
"Kampala", "Kabul", "Walvis Bay", "Islamabad"]
cities.each do |city|
    Location.create(name: city)
end

User.create(full_name: "Admin", role: "admin", email: "admin@bookflix.app", password: "lkss@321")
users = ["Lucas", "Kevin", "Saba", "Samson", "Faranosh", "Jenny"]
users.each do |user|
    User.create(full_name: user, role: "user", email: user+"@bookflix.app", password: "123456")
end

Movie.create(name: "Transformers: Rise of the Beasts ", details: "Optimus Prime and the Autobots take on their biggest challenge yet. When a new threat capable of destroying the entire planet emerges, they must team up with a powerful faction of Transformers known as the Maximals to save Earth.", price: 5.57, duration: 2, image: "https://m.media-amazon.com/images/M/MV5BZTNiNDA4NmMtNTExNi00YmViLWJkMDAtMDAxNmRjY2I2NDVjXkEyXkFqcGdeQXVyMDM2NDM2MQ@@._V1_.jpg", trailer: "https://www.youtube.com/watch?v=itnqEauWQZM")

Movie.create(name: "Mission: Impossible - Dead Reckoning Part One", details: "Whether it's a leaky faucet, a clogged drain, or a plumbing emergency, HandyMate has you covered. Our team of experienced plumbers is skilled in handling a wide range of plumbing issues. We provide timely and reliable solutions to ensure your plumbing systems are functioning properly.", price: 8.57, duration: 2, image: "https://deadline.com/wp-content/uploads/2023/05/image002-1-copy.jpg?w=695", trailer: "https://www.youtube.com/watch?v=avz06PDqDbM")

Movie.create(name: "Fast X", details: "Over many missions and against impossible odds, Dom Toretto and his family have outsmarted and outdriven every foe in their path. Now, they must confront the most lethal opponent they've ever faced. Fueled by revenge, a terrifying threat emerges from the shadows of the past to shatter Dom's world and destroy everything -- and everyone -- he loves.", price: 9.57, duration: 2, image: "https://www.fastxmovie.com/images/main/fastx_mobile_bg.jpg?id=1689824860", trailer: "https://www.youtube.com/watch?v=32RAq6JzY-w")


Movie.create(name: "The Flash", details: "Worlds collide when the Flash uses his superpowers to travel back in time to change the events of the past. However, when his attempt to save his family inadvertently alters the future, he becomes trapped in a reality in which General Zod has returned, threatening annihilation. With no other superheroes to turn to, the Flash looks to coax a very different Batman out of retirement and rescue an imprisoned Kryptonian -- albeit not the one he's looking for.", price: 7.57, duration: 2, image: "https://sportshub.cbsistatic.com/i/2023/05/23/8480a607-63f3-43ff-ad7d-0edb14d96ea5/the-flash-movie-poster-dolby-cinemas.jpg?auto=webp&width=1166&height=1728&crop=0.675:1,smart", trailer: "https://www.youtube.com/watch?v=hebWYacbdvc")

Movie.create(name: "Guardians of the Galaxy Vol. 3", details: "Still reeling from the loss of Gamora, Peter Quill must rally his team to defend the universe and protect one of their own. If the mission is not completely successful, it could possibly lead to the end of the Guardians as we know them.", price: 10.57, duration: 2, image: "https://m.media-amazon.com/images/M/MV5BMDgxOTdjMzYtZGQxMS00ZTAzLWI4Y2UtMTQzN2VlYjYyZWRiXkEyXkFqcGdeQXVyMTkxNjUyNQ@@._V1_FMjpg_UX1000_.jpg", trailer: "https://www.youtube.com/watch?v=u3V5KDHRQvk")

Movie.create(name: "John Wick: Chapter 4", details: "John Wick uncovers a path to defeating The High Table. But before he can earn his freedom, Wick must face off against a new enemy with powerful alliances across the globe and forces that turn old friends into foes.", price: 6.8, duration: 2, image: "https://image.tmdb.org/t/p/original/vppo7eOOkkjoSoBSglYIxLDB0dJ.jpg", trailer: "https://www.youtube.com/watch?v=qEVUtrk8_B4")

Movie.create(name: "Extraction II", details: "After barely surviving his grievous wounds from his mission in Dhaka, Bangladesh, Tyler Rake is back, and his team is ready to take on their next mission.", price: 7.50, duration: 2, image: "https://sportshub.cbsistatic.com/i/2023/05/15/64e0b909-8be4-4215-bbd9-e5049fcab319/extraction-2-posters.jpg?auto=webp&width=1080&height=1350&crop=0.8:1,smart", trailer: "https://www.youtube.com/watch?v=mO0OuR26IZM")

reservations = [
    {start_date: "2021-05-01", end_date: "2021-05-03", location_id: 2, user_id: 1, movie_id: 2},
    {start_date: "2021-05-01", end_date: "2021-05-03", location_id: 3, user_id: 1, movie_id: 3}
]

reservations.each do |reservation|  
    Reservation.create(reservation)
end
