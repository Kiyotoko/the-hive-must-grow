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
    return created
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
    -- TODO: draw worker bee, @leo I am awaiting your sprite!
end

---@class Queen
Queen = {
    goals = { -- NOTICE: names should be uppercase, makes in game font smaller
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
Entities:add(Queen)

function Queen:draw()
    map(0, 0, 30, 30, 3, 3)
end

function Queen:update()
    for _, goal in pairs(self.goals) do
        goal:inc()
    end
end