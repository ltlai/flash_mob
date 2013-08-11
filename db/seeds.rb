require 'faker'
Deck.create(name: "State Capitols")
my_deck = Deck.find_by_name("State Capitols")

Card.create(question: "Washington's capitol", answer: "Olympia", deck_id: my_deck.id)
Card.create(question: "California's capitol", answer: "Sacramento", deck_id: my_deck.id)
Card.create(question: "Oregon's capitol", answer: "Salem", deck_id: my_deck.id)
Card.create(question: "Nevada's capitol", answer: "Carson City", deck_id: my_deck.id)
Card.create(question: "Arizona's capitol", answer: "Phoenix", deck_id: my_deck.id)


Deck.create(name: "Books")
my_book_deck = Deck.find_by_name("Books")

Card.create(question: "Mary _____ was the author of 'Frankenstein'", answer: "Shelley", deck_id: my_book_deck.id)
Card.create(question: "Bram _____ was the author of 'Dracula'", answer: "Stoker", deck_id: my_book_deck.id)
Card.create(question: "Alexandre Dumas was the author of 'The Count of Monte _____'", answer: "Cristo", deck_id: my_book_deck.id)
Card.create(question: "J.R.R. Tolkien is famous for writing 'The Lord of the _____'", answer: "Rings", deck_id: my_book_deck.id)


Deck.create(name: "Mythical Creatures")
my_monsters_deck = Deck.find_by_name("Mythical Creatures")

Card.create(question: "A scaled creature that loves gold is a _____", answer: "dragon", deck_id: my_monsters_deck.id)
Card.create(question: "A horse with a horn is a _____", answer: "unicorn", deck_id: my_monsters_deck.id)
Card.create(question: "A werewolf takes wolf form on the night of the full _____", answer: "moon", deck_id: my_monsters_deck.id)
Card.create(question: "A creature with a man's torso and a horse's body is a _____", answer: "centaur", deck_id: my_monsters_deck.id)


10.times do 
  User.create(:username => Faker::Internet.user_name, :password => 'password')
end

User.create(username: "Clark Kent", password: 'password')

Deck.create(name: "Superheroes")
my_superheroes_deck = Deck.find_by_name("Superheroes")

Card.create(question: "Who's the fastest superhero?", answer: "Flash", deck_id: my_superheroes_deck.id)
Card.create(question: "Who's the best superhero?", answer: "Flash", deck_id: my_superheroes_deck.id)
Card.create(question: "What does the iPad not support?", answer: "Flash", deck_id: my_superheroes_deck.id)