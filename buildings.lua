--- Building is the super class of Belts and co.
Building = {
  icon = {
    timer = Cycle.new{ max = 5 },
    display = Cycle.new{ max = 2 },
  }
}
Building.__index = Building

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

Belt = {
    frames = List.new(),
    icon = {
      frames = List.new()
    },
    timer = Cycle.new{ max=5 },
    display = Cycle.new{ max=2 }
}
Belt.__index = Belt
Belt.frames:add_all{1, 2}
Belt.icon.frames:add_all{1, 2}
setmetatable(Belt, Building)

function Belt.new(vec)
    local created = Building.new(vec)
    setmetatable(created, Belt)
    Overlay:set_building(created.pos.x, created.pos.y, created)
    return created
end

function Belt:draw()
    spr(Belt.frames:get(Belt.display.val), Tile2Pixel(self.pos.x), Tile2Pixel(self.pos.y))
end

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
    Vec2.new{ x=6, y=3 }
}
Drill.icon.frames:add_all{21, 22}
Drill.display.max = Drill.frames:len()

function Drill.new(vec)
    local created = Building.new(vec)
    setmetatable(created, Drill)
    Overlay:set_building(created.pos.x, created.pos.y, created)
    return created
end

function Drill:draw()
    local frame = Drill.frames:get(Drill.display.val)
    map(frame.x, frame.y, Tile2Pixel(self.pos.x), Tile2Pixel(self.pos.y), 3, 3 )
end

Processor = {
  icon = {
    frames = List.new()
  },
}
Processor.__index = Processor
Processor.icon.frames:add_all{0, 16}

function Processor.new(vec)
    local created = Building.new(vec)
    setmetatable(created, Processor)
    Overlay:set_building(created.pos.x, created.pos.y)
    return created
end

function Processor:draw()
    spr(17, Tile2Pixel(self.pos.x), Tile2Pixel(self.pos.y))
end

BuildOptions = List.new()
BuildOptions:add_all{Belt.new, Drill.new, Processor.new}

BuildClassOptions = List.new()
BuildClassOptions:add_all{Belt, Drill, Processor}

SelectedOption = Cycle.new{
    max=BuildOptions:len()
}
