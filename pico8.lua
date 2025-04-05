---@meta pico8
---@diagnostic disable: lowercase-global

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

abs = function (num) end