---Building is the super class of Belts and co.
---@class Building
---@field items List the list of items that is stored in this building
---@field pos Vec2 the position of the top left corner of this building
---@field dim Vec2 the dimensions (w times h) of this building
---@field icon integer the icon tile
---@field new function the constructor of the class
Building = {}
Building.__index = Building

---Creates a new building
---@param pos Vec2
---@param class Building the subclass to use
---@return Building
function Building.new(pos, class)
    assert(pos ~= nil)
    local created = {
        items = List.new(),
        pos = pos
    }
    -- we want to block all fields with dummys to prevent placing a structure inside it
    for x = pos.x, pos.x + class.dim.x do
        for y = pos.y, pos.y + class.dim.y do
            Overlay:set_building(x, y, Dummy)
        end
    end
    Overlay:set_building(created.pos.x, created.pos.y, created)
    setmetatable(created, class)
    return created
end

function Building:update()
    error("unimplemented")
end

function Building:draw()
    error("unimplemented")
end

---@class Drill: Building
Drill = {
    frames = List.new(),
    display = Cycle.new{},
    dim = Vec2.new{ x=3, y=3 },
    icon = 25
}
Drill.__index = Drill
Drill.frames:add_all{
    Vec2.new{ y=3 },
    Vec2.new{ x=3, y=3 },
    Vec2.new{ x=6, y=3 },
    Vec2.new{ x=9, y=3 }
}
Drill.display.max = Drill.frames:len()

function Drill.new(vec)
    return Building.new(vec, Drill)
end

function Drill:update()

end

function Drill:draw()
    local frame = Drill.frames:get(Drill.display.val)
    map(frame.x, frame.y, Tile2Pixel(self.pos.x), Tile2Pixel(self.pos.y), Drill.dim.x, Drill.dim.y)
end

---@class Processor: Building
Processor = {
  frames = List.new(),
  display = Cycle.new{},
  dim = Vec2.new{ x=2, y=2 },
  icon = 17
}
Processor.__index = Processor
Processor.frames:add_all{
    Vec2.new{ x=3 },
    Vec2.new{ x=5 },
    Vec2.new{ x=7 }
}
Processor.display.max = Processor.frames:len()

function Processor.new(vec)
    return Building.new(vec, Processor)
end

function Processor:update()
    
end

function Processor:draw()
    local frame = Processor.frames:get(Processor.display.val)
    map(frame.x, frame.y, Tile2Pixel(self.pos.x), Tile2Pixel(self.pos.y), Processor.dim.x, Processor.dim.y)
end

---Build options is the list of all possible classes that extend from building that the user can build.
BuildOptions = List.new()
BuildOptions:add_all{Drill, Processor}

SelectedOption = Cycle.new{
    max=BuildOptions:len()
}
SwitchCooldown = Cycle.new{max=8}
