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
---@param dummy boolean?
---@return T
function Building.new(pos, class, dummy)
    assert(pos ~= nil)
    local created = {
        items = List.new(),
        pos = pos
    }
    -- we want to block all fields with dummys to prevent placing a structure inside it
    for x = pos.x, pos.x + class.dim.x-1 do
        for y = pos.y, pos.y + class.dim.y-1 do
            Overlay:set_building(x, y, Dummy)
        end
    end
    Overlay:set_building(created.pos.x, created.pos.y, created)
    if not dummy then
        Player.buildings:add(created)
    end
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
    icon = 24,
    price = Inventory.new{
        stone = 3,
        honey = 9
    }
}
Hive.__index = Hive
Hive.display.max = Hive.frames:len()

function Hive.new(vec)
    Bee.new{ x=Tile2Pixel(vec.x+1), y=Tile2Pixel(vec.y+1) }
    return Building.new(vec, Hive, true)
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
    icon = 30,
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

Clock = {
    frames = List.from{ Vec2.new{ y=3 }},
    display = Cycle.new{},
    dim = Vec2.new{ x=3, y=3 },
    icon = 120,
    price = Inventory.new{
        wood = 3
    }
}
Clock.__index = Clock

function Clock.new(pos)
    local created = Building.new(pos, Clock)
    created.cooldown = Cycle.new{ max=105 }
    return created
end

function Clock:update()
    if self.cooldown.val == 0 then
        Player:get_xp(1)
    end
    self.cooldown:inc()
end

function Clock:draw()
    local frame = Clock.frames:get(Storage.display.val)
    map(frame.x, frame.y, Tile2Pixel(self.pos.x), Tile2Pixel(self.pos.y), Clock.dim.x, Clock.dim.y)
end

---@class Storage: Building
Storage = {
    frames = List.from{ Vec2.new{ x=3, y=3 }},
    display = Cycle.new{},
    dim = Vec2.new{ x=3, y=2 },
    icon = 123,
    price = Inventory.new{
        stone = 4
    }
}
Storage.__index = Storage

function Storage.new(pos)
    return Building.new(pos, Storage)
end

function Storage:update()
    for bee in Player.bees:iter() do
        if abs(bee.pos.x - Tile2Pixel(self.pos.x)-4) < 12
        and abs(bee.pos.y - Tile2Pixel(self.pos.y)-4) < 12 then
            local sum = bee.inv.stone + bee.inv.wood + bee.inv.honey
            if sum > 0 then
                Player:get_xp(sum)
                bee.inv:transfer(Player.inv)
                sfx(SOUND.item_transfer)
            end
        end
    end
end

function Storage:draw()
    local frame = Storage.frames:get(Storage.display.val)
    map(frame.x, frame.y, Tile2Pixel(self.pos.x), Tile2Pixel(self.pos.y), Farm.dim.x, Farm.dim.y)
end

Queen = {
    frames = List.from{
        Vec2.new{ x=6, y=3 },
        Vec2.new{ x=9, y=3 }
    },
    display = Cycle.new{ max=2 },
    dim = Vec2.new{ x=3, y=3 },
    icon = 56,
    price = Inventory.new{
        honey = 18
    }
}
Queen.__index = Queen

function Queen.new(pos)
    Player:get_xp(40)
    return Building.new(pos, Queen, true)
end

function Queen:draw()
    local frame = Queen.frames:get(Queen.display.val)
    map(frame.x, frame.y, Tile2Pixel(self.pos.x), Tile2Pixel(self.pos.y), Queen.dim.x, Queen.dim.y)
end

Tradeport = {
    frames = List.from{
        Vec2.new{ }
    },
    display = Cycle.new{},
    dim = Vec2.new{ x=3, y=3 },
    icon = 56,
    price = Inventory.new{
        stone = 4
    }
}
Tradeport.__index = Tradeport

function Tradeport.new(pos)
    local created = Building.new(pos, Tradeport)
    created.cooldown = Cycle.new{ max=16 }
end

function Tradeport:update()
    if self.cooldown.val > 0 then
        self.cooldown:inc()
    elseif Player.inv.honey > 25 then
        Player.inv.honey = Player.inv.honey - 1
        if Player.inv.stone < Player.inv.wood then
            Player.inv.stone = Player.inv.stone + 1
        else
            Player.inv.wood = Player.inv.wood + 1
        end
        self.cooldown:inc()
    end
end

function Tradeport:draw()
    local frame = Tradeport.frames:get(Tradeport.display.val)
    map(frame.x, frame.y, Tile2Pixel(self.pos.x), Tile2Pixel(self.pos.y), Tradeport.dim.x, Tradeport.dim.y)
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
    local created = Building.new(pos, Fauna, true)
    created.type = flr(rnd(2))
    return created
end

function Fauna:draw()
    local frame = Fauna.types:get(self.type)
    map(frame.x, frame.y, Tile2Pixel(self.pos.x), Tile2Pixel(self.pos.y), Fauna.dim.x, Fauna.dim.y)
end

---Build options is the list of all possible classes that extend from building that the user can build.
BuildOptions = List.from{Hive, Farm, Clock, Storage, Queen}

SelectedOption = Cycle.new{
    max=BuildOptions:len()
}
SwitchCooldown = Cycle.new{max=8}
