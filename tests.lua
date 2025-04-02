---@diagnostic disable: lowercase-global
require("table")
require("utils")
require("map")
require("buildings")

rnd = function (table) return 0 end
poke = function (mem, val) end
palt = function (color, visible) end
btn = function (num) return false end
stat = function (mem) return 0 end
cls = function () end
camera = function (x, y) end
spr = function (sprite, x, y) print("spr(" .. sprite .. "," .. x .. "," .. y .. ")") end
---Draws a portion of the map to the graphics buffer.
map = function (celx, cely, sx, sy, celw, celh) print("map()") end
flr = function (num) return math.floor(num) end

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

Underlay:set_field(vec2, 3)
-- FIXME: assert(GameMap:get_field(vec2) == 3, "Expected value 3, but got " .. GameMap:get_field(vec2))
-- assert(GameMap:get_field(Vec2.new{ x=2 }) == DefaultField)

assert(BuildOptions:len() == 3)
SelectedOption:inc()
assert(SelectedOption.val == 1, "Expected value 1, but got " .. SelectedOption:__tostring())
SelectedOption:add(2)
assert(SelectedOption.val == 0, "Expected value 0, but got " .. SelectedOption:__tostring())
SelectedOption:dec()
assert(SelectedOption.val == 2, "Expected value 2, but got " .. SelectedOption:__tostring())

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

local cycle = Cycle.new{ max=3 }
assert(cycle.val == 0)
assert(cycle.max == 3)
cycle:inc()
print(cycle)
cycle:add(2)
assert(cycle.val == 0)
cycle:dec()
assert(cycle.val == 2)

local belt = Belt.new(Vec2)
Overlay:set_building(1, 1, belt)
assert(Overlay:get_building(0, 0) == belt)
print(Overlay[0][0])
Overlay:draw(rect)
