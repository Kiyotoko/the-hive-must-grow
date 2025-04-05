---@diagnostic disable: lowercase-global
require("table")
require("utils")
require("map")
require("buildings")
require("hive")

rnd = function (table) return 0 end
poke = function (mem, val) end
palt = function (color, visible) end
btn = function (num) return false end
stat = function (mem) return 0 end
cls = function () end
camera = function (x, y) end
---Draws a sprite, or a range of sprites, on the screen.
---@param sprite integer The sprite number. When drawing a range of sprites, this is the upper-left corner.
---@param x? number The x coordinate (pixels). The default is 0.
---@param y? number The y coordinate (pixels). The default is 0.
---@param w? number The height of the range, as a number of sprites. Non-integer values may be used to draw partial sprites. Required if w is supplied. The default is 1.0.
---@param h? number The width of the range, as a number of sprites. Non-integer values may be used to draw partial sprites. Requires h to be supplied as well. The default is 1.0.
---@param flip_x? boolean If true, the sprite is drawn inverted left to right. The default is false.
---@param flip_y? boolean If true, the sprite is drawn inverted top to bottom. The default is false.
spr = function (sprite, x, y, h, w, flip_x, flip_y) print("spr(" .. sprite .. "," .. x .. "," .. y .. ")") end
---Draws a portion of the map to the graphics buffer.
map = function (celx, cely, sx, sy, celw, celh) print("map(" .. celx .. "," .. cely .. "," .. sx .. "," .. sy .. "," .. celw .. "," .. celh .. ")") end
flr = function (num) return math.floor(num) end
rectfill = function (x, y, w, h, c) end
sqrt = function (num) return math.sqrt(num) end
atan2 = function (y, x) return math.atan(y, x) end
sin = function (a) return math.sin(a) end
cos = function (a) return math.cos(a) end

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

local worker = Worker.new(Zero)
print("======= Worker Positions =======")
for i = 1, Creatures:len() -1 do
    print(Creatures:get(i).pos)
end
print("================================")
worker.des:add(Vec2.new{ x=4, y=4 })
worker:move()
worker:move()
