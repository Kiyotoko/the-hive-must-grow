--- Building is the super class of Belts and co.
Building = {}
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
    timer = Cycle.new{ max=5 },
    display = Cycle.new{ max=2 }
}
Belt.__index = Belt
Belt.frames:add_all{1, 2}
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

BuildOptions = List.new()
BuildOptions:add_all{Belt.new, Belt.new, Belt.new, Belt.new}

SelectedOption = Cycle.new{
    max=BuildOptions:len()
}
