---The game map is the instance we use to dynamically and infinitly add new tiles to our world.
GameMap = {}

---This is the element number of the tile we use as a default value.
DefaultField = 32

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
        return DefaultField
    else
        return self[x][y] or DefaultField
    end
end

---Draws an area of the map to the display.
---@param rect table the dimensions of the area we want to draw.
function GameMap:draw(rect)
    -- TODO: Add drawing function to draw tiles
    for c = rect.x, rect.x + rect.w do
        for r = rect.y, rect.y + rect.h do
            
            spr(self:get_field0(c, r), c*8, r*8)
            -- io.write(self:get_field0(rect.x + c, rect.y + r))
        end
        -- io.write'\n'
    end
end
