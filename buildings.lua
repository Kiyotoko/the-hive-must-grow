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
---@generic T : Building
---@param pos Vec2
---@param class T the subclass to use
---@return T
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
    Player.buildings:add(created)
    setmetatable(created, class)
    return created
end

function Building:update()
    error("unimplemented")
end

function Building:draw()
    error("unimplemented")
end

---@class Hive: Building
Hive = {
    frames = List.from{
        Vec2.new{ x=6 },
        Vec2.new{ x=9 }
    },
    display = Cycle.new{},
    dim = Vec2.new{ x=3, y=3 },
    icon = 25,
    price = Inventory.new{
        stone = 3,
        honey = 9
    }
}
Hive.__index = Hive
Hive.display.max = Hive.frames:len()

function Hive.new(vec)
    Bee.new{ x=Tile2Pixel(vec.x+1), y=Tile2Pixel(vec.y+1) }
    return Building.new(vec, Hive)
end

function Hive:update()

end

function Hive:draw()
    local frame = Hive.frames:get(Hive.display.val)
    map(frame.x, frame.y, Tile2Pixel(self.pos.x), Tile2Pixel(self.pos.y), Hive.dim.x, Hive.dim.y)
end

---@class Farm: Building
---@field cooldown Cycle
Farm = {
    frames = List.from{
        Zero,
        Vec2.new{ x=3 }
    },
    display = Cycle.new{},
    dim = Vec2.new{ x=3, y=3 },
    icon = 17,
    price = Inventory.new{
        stone = 2,
        honey = 1
    }
}
Farm.__index = Farm
Farm.display.max = Farm.frames:len()

---Creates a new farm.
---@param vec any
---@return Farm
function Farm.new(vec)
    local created = Building.new(vec, Farm)
    created.cooldown = Cycle.new{ max=120 }
    return created
end

function Farm:update()
    if self.cooldown.val > 0 then
        self.cooldown:inc()
    elseif Underlay:get_field0(self.pos.x+1, self.pos.y+1) ~= RESOURCES.honey then
        Underlay:set_field0(self.pos.x+1, self.pos.y+1, RESOURCES.honey)
        self.cooldown:inc()
    end
end

function Farm:draw()
    local frame = Farm.frames:get(Farm.display.val)
    map(frame.x, frame.y, Tile2Pixel(self.pos.x), Tile2Pixel(self.pos.y), Farm.dim.x, Farm.dim.y)
end

---@class Storage: Building
Storage = {
    frames = List.from{ Vec2.new{ y=3 }},
    display = Cycle.new{},
    dim = Vec2.new{ x=3, y=2 },
    icon = 22,
    price = Inventory.new{
        stone = 4
    }
}
Storage.__index = Storage
Storage.display.max = Storage.frames:len()

function Storage.new(pos)
    return Building.new(pos, Storage)
end

function Storage:update()
    for bee in Player.bees:iter() do
        if abs(bee.pos.x - Tile2Pixel(self.pos.x)-4) < 12
        and abs(bee.pos.y - Tile2Pixel(self.pos.y)-4) < 12 then
            Player:get_xp(bee.inv.stone + bee.inv.wood + bee.inv.honey)
            bee.inv:transfer(Player.inv)
        end
    end
end

function Storage:draw()
    local frame = Storage.frames:get(Storage.display.val)
    map(frame.x, frame.y, Tile2Pixel(self.pos.x), Tile2Pixel(self.pos.y), Farm.dim.x, Farm.dim.y)
end

Fauna = {
    types = List.from{
        Vec2.new{ x=12 },
        Vec2.new{ x=13 }
    },
    dim = Vec2.new{ x=1, y=2 }
}
Fauna.__index = Fauna

function Fauna.new(pos)
    local created = Building.new(pos, Fauna)
    created.type = flr(rnd(2))
    return created
end

function Fauna:update() end

function Fauna:draw()
    local frame = Fauna.types:get(self.type)
    map(frame.x, frame.y, Tile2Pixel(self.pos.x), Tile2Pixel(self.pos.y), Fauna.dim.x, Fauna.dim.y)
end

---Build options is the list of all possible classes that extend from building that the user can build.
BuildOptions = List.from{Hive, Farm, Storage}

SelectedOption = Cycle.new{
    max=BuildOptions:len()
}
SwitchCooldown = Cycle.new{max=8}
