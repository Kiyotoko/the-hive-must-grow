---@diagnostic disable: lowercase-global

AnimationTimer = Cycle.new{ max=8 }

function _init()
    -- activate dev mode
    poke(0x5f2d, 1)
    -- change transparency color
    palt(15, true)
    palt(0, false)

    Hive.new{ x=5, y=7 }
    Storage.new{ x=9, y=7 }
end

function _update()
    Player:handle_keys()
    Player:handle_mouse()
    Player:update()
    camera(Cam.x, Cam.y)
end

function _draw()
    AnimationTimer:inc()
    Bee.display:inc()
    if AnimationTimer.val == 0 then
        for option in BuildOptions:iter() do
            option.display:inc()
        end
    end

    cls()

    -- calculate field of view
    local fov = Rect.new{ x=Pixel2Tile(Cam.x)-1, y=Pixel2Tile(Cam.y)-1, w=18, h=18 }
    Underlay:draw(fov)
    Overlay:draw(fov)
    Player:draw()

    local pos = Vec2.new{ x=Tile2Pixel(Pixel2Tile(Cam.x + stat(32))), y=Tile2Pixel(Pixel2Tile(Cam.y + stat(33))) }
    rect(pos.x, pos.y, pos.x + 8, pos.y + 8, 7)

    UI:draw()
    -- draw mouse cursor
    spr(0, Cam.x + stat(32)-1, Cam.y + stat(33)-1)
end
