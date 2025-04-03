MapGen = {
    8,
    24,
    40,
    40,
    40,
    40,
    40,
    40,
    40,
    40,
    40,
    40,
    40,
    40
}

---Returns the next random tile
---@return integer tile the number of the next tile generated
function MapGen:next()
    return rnd(MapGen)
end

---The game map is the instance we use to dynamically and infinitly add new tiles to our world.
Underlay = {}

---Set the field of the game map.
---@param pos table the position of the field you want to change
---@param e integer the element number of the tile
function Underlay:set_field(pos, e)
    self:set_field0(pos.x, pos.y, e)
end

---Elementary function to set the game map. This name is required because lua does not support function overloading.
---@param x integer the x position of the field
---@param y integer the y position of the field
---@param e integer the element bumber of the tile
function Underlay:set_field0(x, y, e)
    if self[x] == nil then
        self[x] = { [y]=e }
    else
        self[x][y] = e
    end
end

function Underlay:get_field(pos)
    return self:get_field0(pos.x, pos.y)
end

function Underlay:get_field0(x, y)
    if self[x] == nil then
        self:set_field0(x, y, MapGen:next())
    elseif self[x][y] == nil then
        self:set_field0(x, y, MapGen:next())
    end
    return self[x][y]
end

---Draws an area of the map to the display.
---@param rect table the dimensions of the area we want to draw.
function Underlay:draw(rect)
    for c = rect.x, rect.x + rect.w do
        for r = rect.y, rect.y + rect.h do
            spr(self:get_field0(c, r), Tile2Pixel(c), Tile2Pixel(r))
        end
    end
end

Overlay = {}

---The dummy value is used to block other fields where the player should not be able to build.
Dummy = Building

function Overlay:set_building(x, y, b)
    if self[x] == nil then
        self[x] = { [y]=b }
    else
        self[x][y] = b
    end
end

function Overlay:get_building(x, y)
    if self[x] == nil then return nil end
    return self[x][y]
end

function Overlay:pop_building(x, y)
    local val = self[x]
    if val ~= nil then
        val = val[y]
        self[x][y] = nil
    end
    return val
end

function Overlay:draw(rect)
    for c = rect.x, rect.x + rect.w do
        for r = rect.y, rect.y + rect.h do
            local field = self:get_building(c, r)
            if field ~= nil then
                field:draw()
            end
        end
    end
end

---@class Entities: List
Entities = List.new()

function Entities:update()
    for i = 0, self:len()-1 do
        self:get(i):update()
    end
end

function Pixel2Tile(pixel)
    return flr(pixel / 8)
end

function Tile2Pixel(tile)
    return tile * 8
end