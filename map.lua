MapDefault = 85

---@enum Resources
RESOURCES = {
    stone = 51,
    wood = 36,
    honey = 34
}

---@class MapGen
---For the map generation, we use an array with different tile numbers.
MapGen = {
    RESOURCES.stone,
    RESOURCES.wood,
    RESOURCES.honey,
    5,  6,  21, 22,
    37, 38,
    85, 85, 85, 85, 85,
    85, 85, 85, 85, 85,
    85, 85, 85, 85, 85,
    85, 85, 85, 85, 85,
    85, 85, 85, 85, 85,
    85, 85, 85, 85, 85,
    85, 85, 85, 85, 85,
    85, 85, 85, 85, 85,
    85, 85, 85, 85, 85,
    85, 85, 85, 85, 85,
    85, 85, 85, 85, 85,
    85, 85, 85, 85, 85,
    85, 85, 85, 85, 85,
    85, 85, 85, 85, 85,
    85, 85, 85, 85, 85,
    85, 85, 85, 85, 85,
    85, 85, 85, 85, 85,
    85, 85, 85, 85, 85,
    85, 85, 85, 85, 85,
    85, 85, 85, 85, 85,
    85, 85, 85, 85, 85
}

---Returns the next random tile.
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
        if Overlay:get_building(x, y) == nil and Overlay:get_building(x, y-1) == nil and rnd(1) > 0.95 then
            Fauna.new{ x=x, y=y }
        end
    elseif self[x][y] == nil then
        self:set_field0(x, y, MapGen:next())
        if Overlay:get_building(x, y) == nil and Overlay:get_building(x, y-1) == nil and rnd(1) > 0.95 then
            Fauna.new{ x=x, y=y }
        end
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

---@class Overlay
Overlay = {}

---The dummy value is used to block other fields where the player should not be able to build.
Dummy = { draw = function () end }

---Set the building to the given position
---@param x integer the x component of the position
---@param y integer the y component of the position
---@param b Building the building that should be set at the position
function Overlay:set_building(x, y, b)
    assert(b ~= nil)
    if self[x] == nil then
        self[x] = { [y]=b }
    else
        self[x][y] = b
    end
end

---Returns the building at the given position. May return `nil` if no building is present.
---May return `Dummy` if this position is blocked by another building or by the hive queen.
---@param x integer the x component of the position
---@param y integer the y component of the position
---@return Building? building
function Overlay:get_building(x, y)
    if self[x] == nil then return nil end
    return self[x][y]
end

---Deletes and returns the building at the given position. If no building is presend, it
---may return `nil` instead.
---@param x integer the x component of the position
---@param y integer the y component of the position
---@return Building? building the building at the given position
function Overlay:pop_building(x, y)
    local val = self[x]
    if val ~= nil then
        val = val[y]
        self[x][y] = nil
    end
    return val
end

---Draws all buildings that are inside the given area.
---@param rect Rect the rect that describes the area that should be drawn
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

---Transforms a pixel coordinate to the corresponding tile.
---@param pixel number the coordinate in pixels
---@return integer tile the coordinate in tiles
function Pixel2Tile(pixel)
    return flr(pixel / 8)
end

---Transforms a tile coordinate to the corresponding pixel.
---@param tile integer the coordinate in tiles
---@return number pixle the coordinate in pixels
function Tile2Pixel(tile)
    return tile * 8
end
