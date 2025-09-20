# frozen_string_literal: true

Game.delete_all
Player.delete_all
Family.delete_all
Pet.delete_all
Target.delete_all
Treat.delete_all
Level.delete_all

ApplicationRecord.connection.execute("DELETE FROM sqlite_sequence")

Pet.create!(name: "Dog", image_name: "dog.png")
Pet.create!(name: "Cat", image_name: "cat.png")
Pet.create!(name: "Turtle", image_name: "turtle.png")

Target.create!(name: "Dogs' ice cream", image_name: "dog_ice_cream.png")
Target.create!(name: "Apple", image_name: "apple.png")
Target.create!(name: "Bowl", image_name: "cat_bowl.png")

Treat.create!(name: "bone", image_name: "bone.png", points: 10)
Treat.create!(name: "Fish", image_name: "fish.png", points: 10)
Treat.create!(name: "Salad", image_name: "salad.png", points: 10)

# Level 0 - just go up
Level.create!(
  pet: { x: 1, y: 3 },
  target: { x: 1, y: 2 },
)

# Level 1 - Same, but add a treat
Level.create!(
  pet: { x: 1, y: 3 },
  target: { x: 1, y: 2 },
  treats: [
    { x: 0, y: 3 },
  ],
)

# Level 2 - watch out the holes
Level.create!(
  pet: { x: 1, y: 3 },
  target: { x: 1, y: 1 },
  holes: [
    { x: 1, y: 2 },
  ],
  treats: [
    { x: 0, y: 3 },
  ],
)
# Level 3 - spiral
Level.create!(
  pet: { x: 5, y: 5 },
  target: { x: 3, y: 6 },
  walls: [
    { x: 4, y: 5 },
    { x: 4, y: 6 },
    { x: 5, y: 6 },
    { x: 6, y: 6 },

    { x: 6, y: 5 },
    { x: 6, y: 4 },
    { x: 6, y: 3 },

    { x: 5, y: 3 },
    { x: 4, y: 3 },
    { x: 3, y: 3 },
    { x: 2, y: 3 },
    { x: 1, y: 3 },

    { x: 1, y: 4 },
    { x: 1, y: 5 },
    { x: 1, y: 6 },

    { x: 3, y: 5 },

    { x: 1, y: 7 },
    { x: 2, y: 7 },
    { x: 3, y: 7 },
    { x: 4, y: 7 },
    { x: 5, y: 7 },
    { x: 6, y: 7 },
  ],
)

# Level 4 - loops
Level.create!(
  pet: { x: 0, y: 0 },
  target: { x: 9, y: 9 },
  walls: [
    { x: 0, y: 9 },
    { x: 9, y: 0 },

    { x: 8, y: 8 },
  ],
)
