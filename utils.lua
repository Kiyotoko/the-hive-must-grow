---Generic 2D vector.
Vec2 = { x=0, y=0 }
Vec2.__index = Vec2

---Creates a new 2D vector. If no x or y is supplied, it will use 0 instead.
---@param data table the x and y coordinate for the vector
---@return table vector the newly created vector
function Vec2.new(data)
    assert(data ~= nil)
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
    assert(data ~= nil)
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

List = { __len=0 }
List.__index = List

function List.new()
    local created = {}
    setmetatable(created, List)
    created.__len = 0
    return created
end

function List:add(e)
    self[self.__len] = e
    self.__len = self.__len + 1
end

function List:set(i, e)
    assert(i < self.__len and i >= 0, "Index out of bounds")
    self[i] = e
end

function List:get(i)
    assert(i < self.__len and i >= 0, "Index out of bounds")
    return self[i]
end

function List:pop(i)
    assert(i < self.__len and i >= 0, "Index out of bounds")
    -- cache removed value
    local val = self[i]
    -- rotate index of all following values
    for j = i, self.__len - 2 do
        self[j] = self[j+1]
    end
    -- decrease len of List
    self.__len = self.__len - 1
    -- delete last unused index
    self[self.__len] = nil
    -- deli(self.__len) TODO: replace with pico 8 function
    return val
end

function List:len()
    return self.__len
end

function List:__tostring()
    if self.__len > 0 then
        local content = "List[" .. self[0]
        for i = 1, self.__len-1 do
            content = content .. ", " .. self[i]
        end
        return content .. "]"
    else
        return "List[]"
    end
end

