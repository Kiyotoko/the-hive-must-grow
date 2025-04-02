MapGen = {
    8,
    24,
    24,
    40,
    40,
    40,
    40
}

function MapGen:next()
    return rnd(MapGen)
end

---The game map is the instance we use to dynamically and infinitly add new tiles to our world.
GameMap = {}

---Set the field of the game map.
---@param pos table the position of the field you want to change
---@param e integer the element number of the tile
function GameMap:set_field(pos, e)
    self:set_field0(pos.x, pos.y, e)
end

---Elementary function to set the game map. This name is required because lua does not support function overloading.
---@param x integer the x position of the field
---@param y integer the y position of the field
---@param e integer the element bumber of the tile
function GameMap:set_field0(x, y, e)
    if self[x] == nil then
        self[x] = { [y]=e }
    else
        self[x][y] = e
    end
end

function GameMap:get_field(pos)
    return self:get_field0(pos.x, pos.y)
end

function GameMap:get_field0(x, y)
    if self[x] == nil then
        self:set_field0(x, y, MapGen:next())
    elseif self[x][y] == nil then
        self:set_field0(x, y, MapGen:next())
    end
    return self[x][y]
end

---Draws an area of the map to the display.
---@param rect table the dimensions of the area we want to draw.
function GameMap:draw(rect)
    for c = rect.x, rect.x + rect.w do
        for r = rect.y, rect.y + rect.h do
            spr(self:get_field0(c, r), Tile2Pixel(c), Tile2Pixel(r))
        end
    end
end

GameBuildings = {}

function GameBuildings:put(key, building)
    assert(key ~= nil and building ~= nil)
    GameBuildings[key] = building
end

function GameBuildings:get(key)
    assert(key ~= nil)
    return GameBuildings[key]
end

function GameBuildings:update()
    for _, value in pairs(self) do
        value:update()
    end
end

function GameBuildings:draw()
    for _, value in pairs(self) do
        value:draw()
    end
end

function Pixel2Tile(pixel)
    return flr(pixel / 8)
end

function Tile2Pixel(tile)
    return tile * 8
end