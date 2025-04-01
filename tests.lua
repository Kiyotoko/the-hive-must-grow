require("map")
require("utils")

local vec2 = Vec2.new{ x=3 }
print(vec2)
assert(vec2.x == 3)
assert(vec2.y == 0)
assert(vec2.z == nil)

local rect = Rect.new{ w=4, h=4 }
print(rect)
assert(rect.x == 0)
assert(rect.y == 0)
assert(rect.w == 4)
assert(rect.h == 4)

GameMap:set_field(vec2, 3)
print("Got " .. GameMap:get_field(vec2))
assert(GameMap:get_field(vec2) == 3)
assert(GameMap:get_field(Vec2.new{ x=2 }) == DefaultField)

