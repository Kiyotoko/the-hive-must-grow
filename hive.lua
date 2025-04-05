---@class Creatures: List
Creatures = List.new()

function Creatures:update()
    for i = 0, self:len()-1 do
        self:get(i):update()
    end
end

function Creatures:draw()
    for i = 0, self:len()-1 do
        self:get(i):draw()
    end
end

---The worker bee. Worker bees are used to transport items to the hive queen.
---@class Worker
---@field des List
---@field pos Vec2
Worker = {}
Worker.__index = Worker

function Worker.new(pos)
    local created = {}
    setmetatable(created, Worker)
    created.des = List.new()
    created.pos = pos
    Creatures:add(created)
    return created
end

function Worker:update()
    self:move()
    -- TODO: add item transport here
end

function Worker:move()
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
        end
    end
end

function Worker:draw()
    spr(9, self.pos.x, self.pos.y)
end

-- TODO: these bees are only created for testing
Worker.new(Vec2.new{ x=3, y=8 })
Worker.new(Vec2.new{ x=9, y=2 })


---@class Queen
Queen = {
    goals = {
        Cycle.new{max = 30 * 60},
        Cycle.new{max = 5 * 30 * 60},
        Cycle.new{max = 10 * 30 * 60},
    },
    goal_names = {
        "DRINK",
        "EAT",
        "HAT"
    }
}
Creatures:add(Queen)

for x = 5, 7 do
    for y = 7, 9 do
        Overlay:set_building(x, y, Dummy)
    end
end

function Queen:draw()
    map(0, 0, Tile2Pixel(5), Tile2Pixel(7), 3, 3)
end

function Queen:update()
    for _, goal in pairs(self.goals) do
        goal:inc()
    end
end