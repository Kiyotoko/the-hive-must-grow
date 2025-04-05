---Generic 2D vector.
---@class Vec2
---@field x number the x component of this vector
---@field y number the y component of this vector
Vec2 = {}
Vec2.__index = Vec2

---Creates a new 2D vector. If no x or y is supplied, it will use 0 instead.
---@param data table the x and y coordinate for the vector
---@return Vec2 vector the newly created vector
---@nodiscard
function Vec2.new(data)
    assert(data ~= nil)
    local created = {}
    setmetatable(created, Vec2)
    created.x = data.x or 0
    created.y = data.y or 0
    return created
end

Zero = Vec2.new{ x=0, y=0 }

function Vec2:__tostring()
    return "Vec2[x=" .. self.x .. ", y=" .. self.y .. "]"
end

---@class Rect
---@field x number the x start position
---@field y number the y start position
---@field w number the width of the rectangle
---@field h number the height of the rectangle
Rect = {}
Rect.__index = Rect

---Creates a new rect from a given rect or table. If x or y is not given, it will use 0 instead.
---@param data table
---@return Rect
---@nodiscard
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

---@class List<E>: { [integer]: E }
List = { __len=0 }
List.__index = List

---Creates a new list with an init capacity of 0.
---@return List
---@nodiscard
function List.new()
    local created = {}
    setmetatable(created, List)
    created.__len = 0
    return created
end

function List.from(data)
    local created = List.new()
    created:add_all(data)
    return created
end

---Adds the given element to the end of the list.
---@param e any the element to add
function List:add(e)
    self[self.__len] = e
    self.__len = self.__len + 1
end

---Adds all given elements to the end of the list.
---@param table any the table of elements to add
function List:add_all(table)
    assert(table ~= nil)
    for _, value in ipairs(table) do
        self:add(value)
    end
end

---Sets the element of a given index in the list to the new given element.
---@param i integer the index of the element that is set
---@param e any the new element to set
function List:set(i, e)
    assert(i < self.__len and i >= 0, "Index out of bounds")
    self[i] = e
end

---Returns the currently presend element at the given index of the list.
---@param i integer the index of the element you want to get
---@return any e the element at the given position
---@nodiscard
function List:get(i)
    assert(i < self.__len and i >= 0, "Index out of bounds")
    return self[i]
end

---Removes and returns the element at the given index of the list. This will shift all element
---indices that are presend after this element one to the left.
---@param i integer the index of the element that should be removed
---@return any e the element that was removed
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

function List:clear()
    for i = 0, self:len()-1 do
        self[i] = nil
    end
    self.__len = 0
end

function List:is_empty()
    return self:len() == 0
end

function List:iter()
    local i = -1
    local l = self:len()
    return function ()
        i = i+1
        if i<l then return self[i] end
    end
end

---@return integer len the len or number of elements of this list
---@nodiscard
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

---@class Cycle
---@field val integer
---@field max integer
Cycle = {}
Cycle.__index = Cycle  -- Set metatable index to itself

---Creates a new cycle object
---@param data table
---@return Cycle
---@nodiscard
function Cycle.new(data)
    assert(data ~= nil)
    local created = {}  -- Create a new object (table)
    setmetatable(created, Cycle)  -- Set metatable
    created.val = data.val or 0
    created.max = data.max or 1
    return created
end

function Cycle:inc()
    self:add(1)
end

function Cycle:dec()
    self:add(self.max - 1)
end

function Cycle:add(val)
    self.val = (self.val + val) % self.max
end

function Cycle:reset()
    self.val = 0
end

function Cycle:__tostring()
    return "Cycle[" .. self.val .. "/" .. self.max .. "]"
end
