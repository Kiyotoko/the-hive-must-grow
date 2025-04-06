---@class Inventory
Inventory = {}
Inventory.__index = Inventory

---Creates a new inventory from a given data set.
---@param data table
---@return Inventory
function Inventory.new(data)
    local created = {
        stone = data.stone or 0,
        wood = data.wood or 0,
        honey = data.honey or 0
    }
    setmetatable(created, Inventory)
    return created
end

---Transfar all items from this inventory to the given inventory.
---@param inv Inventory the inventory to which the resources should be transferred
function Inventory:transfer(inv)
    inv:pickup(self)
    self:clear()
end

function Inventory:pickup(inv)
    self.stone = self.stone + (inv.stone or 0)
    self.honey = self.honey + (inv.honey or 0)
    self.wood = self.wood + (inv.wood or 0)
end

function Inventory:consume(inv)
    if self.stone >= (inv.stone or 0) and self.honey >= (inv.honey or 0) and self.wood >= (inv.wood or 0) then
        self.stone = self.stone - (inv.stone or 0)
        self.wood = self.wood - (inv.wood or 0)
        self.honey = self.honey - (inv.honey or 0)
        return true
    end
    return false
end

function Inventory:clear()
    self.stone = 0
    self.honey = 0
    self.wood = 0
end

Player = {
    inv = Inventory:new(),
    bees = List.new(),
    buildings = List.new(),
    selected = nil,
    xp = 0,
    lvl = 1
}

---Offset and speed of the camera.
Cam = {
    x = 0,
    y = 0,
    speed = 5
}

function Player:handle_keys()
    if btn(0) then Cam.x = Cam.x - Cam.speed end
    if btn(1) then Cam.x = Cam.x + Cam.speed end
    if btn(2) then Cam.y = Cam.y - Cam.speed end
    if btn(3) then Cam.y = Cam.y + Cam.speed end
    if SwitchCooldown.val == 0 then
        if btn(4) then
            ControlMode = not ControlMode
            SwitchCooldown.val = 1
        end
        if btn(5) and not ControlMode then
            SelectedOption:inc()
            SwitchCooldown.val = 1
        end
    else
        SwitchCooldown:inc()
    end
end

function Player:handle_mouse()
    local mouse = stat(34)
    local pos = Vec2.new{
            x=Cam.x + stat(32)-1,
            y=Cam.y + stat(33)-1
    }
    if mouse > 0 then
        if ControlMode then
            -- TODO: control the hive!
            if mouse == 1 then
                -- we start by the index 1 and NOT 0, because the queen is always
                -- located at index 0 and we do not want to control or move the queen.
                Player.selected = nil -- deselect previously selected worker
                for bee in self.bees:iter() do
                    assert(bee ~= nil, "Bee should not be nil")
                    if bee.pos.x < pos.x and pos.x < bee.pos.x + 8
                    and bee.pos.y < pos.y and pos.y < bee.pos.y + 8 then
                        Player.selected = bee
                        return
                    end
                end
            elseif mouse == 2 and Player.selected ~= nil then
                if not btn(5) then
                    Player.selected.des:clear()
                end
                Player.selected.des:add(pos)
            end
        else
            -- current moused tile
            local tile = Vec2.new{
                    x=Pixel2Tile(pos.x),
                    y=Pixel2Tile(pos.y)
            }
            -- LMB
            if mouse == 1 then
                if Overlay:get_building(tile.x, tile.y) == nil then
                    local option = BuildOptions[SelectedOption.val]
                    -- check if there is already a building presend at the position
                    for dx = 0, option.dim.x-1 do
                        for dy = 0, option.dim.y-1 do
                            if Overlay:get_building(tile.x + dx, tile.y + dy) ~= nil then
                                -- another building is already presend, therefore we directly go to exit
                                return
                            end
                        end
                    end
                    if Player.inv:consume(option.price) then
                        option.new(tile)
                        Player:get_xp(10)
                    end
                end
            -- RMB
            elseif mouse == 2 then
                Overlay:pop_building(tile.x, tile.y)
            end
        end
    end
end

function Player:get_xp(val)
    self.xp = self.xp + val
    while self.lvl * 10 <= self.xp do
        self.xp = self.xp - self.lvl * 10
        self.lvl = self.lvl + 1
    end
end

function Player:update()
    for bee in self.bees:iter() do
        bee:update()
    end
    for building in self.buildings:iter() do
        building:update()
    end
end

function Player:draw()
    for bee in self.bees:iter() do
        bee:draw()
    end
end

---The worker bee. Worker bees are used to transport items to the storage.
---@class Bee
---@field des List
---@field pos Vec2
---@field inv Inventory
Bee = {
    frames = List.from{3, 4},
    display = Cycle.new{}
}
Bee.__index = Bee
Bee.display.max = Bee.frames:len()

function Bee.new(pos)
    assert(pos ~= nil)
    local created = {
        des = List.new(),
        pos = pos,
        inv = Inventory.new{}
    }
    setmetatable(created, Bee)
    Player.bees:add(created)
    return created
end

function Bee:update()
    self:move()
    local tile = Vec2.new{
        x=Pixel2Tile(self.pos.x+4),
        y=Pixel2Tile(self.pos.y+4)
    }
    local n = Underlay:get_field(tile)
    if n == RESOURCES.stone then
        Underlay:set_field(tile, MapDefault)
        self.inv:pickup{ stone=1 }
    elseif n == RESOURCES.wood then
        Underlay:set_field(tile, MapDefault)
        self.inv:pickup{ wood=1 }
    elseif n == RESOURCES.honey then
        Underlay:set_field(tile, MapDefault)
        self.inv:pickup{ honey=1 }
    end
end

function Bee:move()
    if self.des:len() > 0 then
        local next = self.des:get(0)
        local dx = next.x - self.pos.x
        local dy = next.y - self.pos.y
        local diff = sqrt(dy*dy + dx*dx)
        if diff > 1 then
            self.pos = Vec2.new{
                x=self.pos.x + dx/diff,
                y=self.pos.y + dy/diff
            }
        else
            self.pos = self.des:pop(0)
            if self.des:len() > 0 then
                self.des:add(next)
            end
        end
    end
end

function Bee:draw()
    if self == Player.selected then
        circfill(self.pos.x + 4, self.pos.y + 4, 3 + Hive.display.val, 8)
        if self.des:len() > 0 then
            local next = self.des:get(0)
            -- We need to add 4 to all coordinates, because the position is saved as the top left corner.
            -- But because we want to use the center of the tile, we need to add half the wide and height of a tile, which is in both cases 4.
            line(self.pos.x+4, self.pos.y+4, next.x+4, next.y+4, 8)
        end
    end

    local tile = Bee.frames:get(Bee.display.val)
    if self.des:is_empty() then
        spr(tile, self.pos.x, self.pos.y)
    else
        spr(tile, self.pos.x, self.pos.y, 1.0, 1.0, self.pos.x > self.des:get(0).x)
    end
end

