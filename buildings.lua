---Building is the super class of Belts and co.
---@class Building
---@field items List the list of items that is stored in this building
---@field pos Vec2 the position of the top left corner of this building
---@field new function the constructor of the class
Building = {
  icon = {
    timer = Cycle.new{ max = 5 },
    display = Cycle.new{ max = 2 },
  }
}
Building.__index = Building

---Creates a new building
---@param vec Vec2
---@return Building
function Building.new(vec)
    assert(vec ~= nil)
    local created = {
        items = List.new(),
        pos = vec
    }
    setmetatable(created, Building)
    return created
end

function Building:update()
    -- TODO: add imlementation
end

function Building:draw()
    error("unimplemented")
end

function Building:__tostring()
    return "Building[]"
end

---@class Drill: Building
Drill = {
    frames = List.new(),
    icon = {
      frames = List.new(),
    },
    timer = Cycle.new{ max=5 },
    display = Cycle.new{}
}
Drill.__index = Drill
Drill.frames:add_all{
    Vec2.new{ y=3 },
    Vec2.new{ x=3, y=3 },
    Vec2.new{ x=6, y=3 },
    Vec2.new{ x=9, y=3 }
}
Drill.icon.frames:add_all{21, 22}
Drill.display.max = Drill.frames:len()

function Drill.new(vec)
    -- check if a building is already present
    for x = -1, 1 do
        for y = -1, 1 do
            if Overlay:get_building(vec.x + x, vec.y + y) ~= nil then
                -- another building is already build at this place, we can not create a new drill at this position
                return nil
            end
        end
    end

    local created = Building.new(vec)
    setmetatable(created, Drill)
    -- fill all blocked positions with dummies
    for x = -1, 1 do
        for y = -1, 1 do
            Overlay:set_building(created.pos.x + x, created.pos.y + y, Dummy)
        end
    end
    Overlay:set_building(created.pos.x-1, created.pos.y-1, created)
    return created
end

function Drill:draw()
    local frame = Drill.frames:get(Drill.display.val)
    map(frame.x, frame.y, Tile2Pixel(self.pos.x), Tile2Pixel(self.pos.y), 3, 3 )
end

---@class Processor: Building
Processor = {
  icon = {
    frames = List.new()
  },
}
Processor.__index = Processor
Processor.icon.frames:add_all{17, 17}

function Processor.new(vec)
    local created = Building.new(vec)
    setmetatable(created, Processor)
    Overlay:set_building(created.pos.x, created.pos.y, created)
    return created
end

function Processor:draw()
    spr(17, Tile2Pixel(self.pos.x), Tile2Pixel(self.pos.y))
end

---Build options is the list of all possible classes that extend from building that the user can build.
BuildOptions = List.new()
BuildOptions:add_all{Drill, Processor}

SelectedOption = Cycle.new{
    max=BuildOptions:len()
}
SwitchCooldown = Cycle.new{max=15}
