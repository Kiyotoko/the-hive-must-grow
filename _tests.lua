require("_pico8")
require("utils")
require("player")
require("map")
require("buildings")

local vec2 = Vec2.new{ x=3 }
print(vec2)
assert(vec2.x == 3)
assert(vec2.y == 0)
---@diagnostic disable-next-line: undefined-field
assert(vec2.z == nil)

local rect = Rect.new{ w=4, h=4 }
print(rect)
assert(rect.x == 0)
assert(rect.y == 0)
assert(rect.w == 4)
assert(rect.h == 4)

Underlay:set_field(vec2, 3)
-- FIXME: assert(GameMap:get_field(vec2) == 3, "Expected value 3, but got " .. GameMap:get_field(vec2))
-- assert(GameMap:get_field(Vec2.new{ x=2 }) == DefaultField)

local list = List.new()
print(list)
for e = 1, 5 do
    list:add(e)
    assert(list:get(e-1) == e)
end
print(list)
assert(list:len() == 5)
for e in list:iter() do
    print(e)
end
assert(list:pop(1) == 2)
assert(list:pop(2) == 4)
assert(list:len() == 3)
print(list)

local cycle = Cycle.new{ max=3 }
assert(cycle.val == 0)
assert(cycle.max == 3)
cycle:inc()
print(cycle)
cycle:add(2)
assert(cycle.val == 0)
cycle:dec()
assert(cycle.val == 2)
