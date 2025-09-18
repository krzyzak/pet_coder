Game.delete_all
Player.delete_all
Pet.delete_all
Target.delete_all
Treat.delete_all

Level.create!(
  pet: { x: 1, y: 3 },
  target: { x: 1, y: 2 },
)

dog = Pet.create!(name: "Dog", image_name: "dog.png")
dog_ice_cream = Target.create!(name: "Dogs' ice cream", image_name: "dog_ice_cream.png")
bone = Treat.create!(name: "bone", image_name: "bone.png", points: 10)

Player.create!(name: "Marysia", pet: dog, treat: bone, target: dog_ice_cream)

#  {
#     player: Point.new(x: 1, y: 3),
#     target: Point.new(x: 1, y: 2),
#   },
#   # Level 1 - same, but add a treat
#   {
#     player: Point.new(x: 1, y: 3),
#     target: Point.new(x: 1, y: 2),
#     treats: [
#       Treat.new(position: Point.new(x: 0, y: 3)),
#     ],
#   },

# EVELS_DATA = [
#   # Level 0 - just go up
#   {
#     player: Point.new(x: 1, y: 3),
#     target: Point.new(x: 1, y: 1),
#     treats: [
#       Treat.new(position: Point.new(x: 1, y: 2)),
#     ],
#   },
#   # Level 1 - spiral
#   {
#     player: Point.new(x: 5, y: 5),
#     walls: [
#       Point.new(x: 4, y: 5),
#       Point.new(x: 4, y: 6),
#       Point.new(x: 5, y: 6),
#       Point.new(x: 6, y: 6),

#       Point.new(x: 6, y: 5),
#       Point.new(x: 6, y: 4),
#       Point.new(x: 6, y: 3),

#       Point.new(x: 5, y: 3),
#       Point.new(x: 4, y: 3),
#       Point.new(x: 3, y: 3),
#       Point.new(x: 2, y: 3),
#       Point.new(x: 1, y: 3),

#       Point.new(x: 1, y: 4),
#       Point.new(x: 1, y: 5),
#       Point.new(x: 1, y: 6),

#       Point.new(x: 3, y: 5),

#       Point.new(x: 1, y: 7),
#       Point.new(x: 2, y: 7),
#       Point.new(x: 3, y: 7),
#       Point.new(x: 4, y: 7),
#       Point.new(x: 5, y: 7),
#       Point.new(x: 6, y: 7),
#     ],
#     target: Point.new(x: 3, y: 6),
#   },

#   # {
#   #   turtle: Point.new(x: 1, y: 3),
#   #   apple: Point.new(x: 6, y: 2),
#   # },
#   {
#     player: Point.new(x: 0, y: 0),
#     walls: [
#       Point.new(x: 0, y: 9),
#       Point.new(x: 9, y: 0),

#       Point.new(x: 8, y: 8),
#     ],
#     target: Point.new(x: 9, y: 9),
#   },
# ]
