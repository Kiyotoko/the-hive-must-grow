---@diagnostic disable: lowercase-global
-- offset of the camera
Cam = {
    x = 0,
    y = 0,
    speed = 5
}

-- game logic
Game = {
  state = Cycle.new{max = 2}, -- 0: Title Screen, 1: Playing, 2: Game Over
  timerindex = { "DRINK", "EAT", "HAT" },
  timers = { -- NOTICE: names should be uppercase, makes in game font smaller
    DRINK = Cycle.new{max = 30 * 60},
    EAT = Cycle.new{max = 5 * 30 * 60},
    HAT = Cycle.new{max = 10 * 30 * 60},
  }
}

function _init()
    -- activate dev mode
    poke(0x5f2d, 1)
    -- change transparency color
    palt(15, true)
    palt(0, false)
end

function _update()
    if btn(0) then Cam.x = Cam.x - Cam.speed end
    if btn(1) then Cam.x = Cam.x + Cam.speed end
    -- deactivate y axis control
    -- if btn(2) then cam.y = cam.y + 1 end
    -- if btn(3) then cam.y = cam.y - 1 end
    if btn(4) then SelectedOption:inc() end
    if btn(5) then SelectedOption:dec() end

    local mouse = stat(34)
    -- current moused tile
    tile = Vec2.new{
            x=Pixel2Tile(Cam.x + stat(32)-1),
            y=Pixel2Tile(Cam.y + stat(33)-1)
    }
    -- LMB
    if mouse == 1 then
        local factory = BuildOptions[SelectedOption.val]
        factory(tile)
    -- RMB
    elseif mouse > 0 then
        Overlay:pop_building(tile.x, tile.y)
    end

    camera(Cam.x, Cam.y)

    Building.icon.timer:inc()
    if Building.icon.timer.val == 0 then
        Building.icon.display:inc()
    end

    Belt.timer:inc()
    if Belt.timer.val == 0 then
        Belt.display:inc()
    end
    Drill.timer:inc()
    if Drill.timer.val == 0 then
        Drill.display:inc()
    end

    -- Update Gameloop timers 
    for _, k in pairs(Game.timers) do
      k:inc()
    end
    -- TODO: also check whether Queen has been fed
    -- TODO: game over checks (if timer == 0 && Queen not fed)
    -- TODO: implement a way to reattempt / Game over screen (see Game.state)
end

function _draw()
    cls()

    -- calculate field of view
    local fov = Rect.new{ x=Pixel2Tile(Cam.x), w=16, h=13 }
    Underlay:draw(fov)
    Overlay:draw(fov)
    -- draw tile indicator
    spr(16, tile.x * 8, tile.y * 8)

    UI:draw()
    -- draw mouse cursor
    spr(0, Cam.x + stat(32)-1, Cam.y + stat(33)-1)
end
