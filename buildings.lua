--- Building is the super class of bells and co.
Building = {}
Building.__index = Building

BuildOptions = List.new()
BuildOptions:add(1)
BuildOptions:add(3)
BuildOptions:add(5)
BuildOptions:add(17)

SelectedOption = Cycle.new{
    max=BuildOptions:len()
}

function Building.new(vec)
    assert(vec ~= nil)
    local created = {
        items = List.new(),
        frames = List.new(),
        display = Cycle.new{},
        timer = Cycle.new{},
        pos = vec or Vec2
    }
    setmetatable(created, Building)
    return created
end

function Building:update()
    self.timer:inc()
    if self.timer.val == 0 then
        self.display:inc()
    end
end

function Building:free()
    error("Unimplemented") -- do not call, override instead
end

function Building:draw()

end

function Building:push_frame(frame)
    self.frames:add(frame)
    self.display.max = self.frames:len()
end

function Building:__tostring()
    return "Building[]"
end

Bell = {}
Bell.__index = Bell
setmetatable(Bell, Building)

function Bell.new(vec)
    local created = Building.new(vec)
    GameBuildings:put(GenKey(created), created)
    setmetatable(created, Bell)
end

function Bell:update()
    print("Hello World!")
end

function GenKey(building)
    assert(building ~= nil)
    return building.pos.x .. ":" .. building.pos.y
end
