require("table")
require("utils")
require("map")
require("buildings")

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
assert(GameMap:get_field(vec2) == 3, "Expected value 3, but got " .. GameMap:get_field(vec2))
assert(GameMap:get_field(Vec2.new{ x=2 }) == DefaultField)

assert(BuildOptions:len() == 3)
SelectedOption = (SelectedOption + 1) % BuildOptions:len()
assert(SelectedOption == 1, "Expected value 1, but got " .. SelectedOption)
SelectedOption = (SelectedOption + 2) % BuildOptions:len()
assert(SelectedOption == 0, "Expected value 0, but got " .. SelectedOption)
SelectedOption = (SelectedOption + BuildOptions:len() - 1) % BuildOptions:len()
assert(SelectedOption == 2, "Expected value 2, but got " .. SelectedOption)

local building = Building.new{ tile=42 }
print(building)
assert(building.tile == 42)
assert(building.pos == nil)
building:place(Vec2)
assert(building.pos == Vec2)
print(building)

local list = List.new()
print(list)
for e = 1, 5 do
    list:add(e)
    assert(list:get(e-1) == e)
end
print(list)
assert(list:len() == 5)
assert(list:pop(1) == 2)
assert(list:pop(2) == 4)
assert(list:len() == 3)
print(list)
