---Generic 2D vector.
Vec2 = { x=0, y=0 }
Vec2.__index = Vec2

---Creates a new 2D vector. If no x or y is supplied, it will use 0 instead.
---@param data table the x and y coordinate for the vector
---@return table vector the newly created vector
function Vec2.new(data)
    local created = {}
    setmetatable(created, Vec2)
    created.x = data.x or 0
    created.y = data.y or 0
    return created
end

function Vec2:__tostring()
    return "Vec2[x=" .. self.x .. ", y=" .. self.y .. "]"
end

Rect = {}
Rect.__index = Rect

function Rect.new(data)
    local created = {}
    setmetatable(created, Rect)
    created.x = data.x or 0
    created.y = data.y or 0
    created.w = data.w or 1
    created.h = data.h or 1
    assert(created.w > 0, "The width must be > 0!")
    assert(created.h > 0, "The height must be > 0!")
    return created
end

function Rect:__tostring()
    return "Rect[x=" .. self.x .. ", y=" .. self.y .. ", w=" .. self.w .. ", h=" .. self.h .. "]"
end
