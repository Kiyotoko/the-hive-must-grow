-- Define a class
Building = {}
Building.__index = Building  -- Set metatable index to itself

BuildOptions = List.new()
BuildOptions:add(48)
BuildOptions:add(32)
BuildOptions:add(49)

SelectedOption = 0

-- Constructor
function Building.new(data)
    assert(data ~= nil)
    local created = {}
    setmetatable(created, Building)  -- Set metatable
    created.tile = data.tile or DefaultField
    created.items = List.new()
    return created
end

function Building:place(pos)
    self.pos = pos or Vec2
    self.rotation = 0 -- TODO: add current roatition value
end

function Building:update()
    error("Unimplemented") -- do not call, override instead
end

function Building:__tostring()
    return "Building[" .. (self.pos ~= nil and self.pos:__tostring() or "nil") .. ", " .. self.tile .. ", " .. (self.items[0] ~= nil and "some" or "none").. "]"
end

Bell = Building.new{ tile=48 }

function Bell.new()
    local created = {}
    setmetatable(created, Bell)
end

function Bell:update()
    print("Hello World!")
end