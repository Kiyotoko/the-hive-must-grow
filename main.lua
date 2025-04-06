---@diagnostic disable: lowercase-global

AnimationTimer = Cycle.new{ max=15 }
GameStarted = true

function _init()
    -- activate dev mode
    poke(0x5f2d, 1)
    -- change transparency color
    palt(15, true)
    palt(0, false)

    Hive.new{ x=5, y=7 }
    Storage.new{ x=9, y=7 }
    for x = 4, 10 do
        for y = 7, 10 do
            Underlay:set_field0(x, y, MapDefault)
        end
    end

    -- draw title screen
    cls()
    map(0, 6, 64 - 6*8, 30, 12, 6)
    print("PRESS ANY KEY TO START", 20, 90, 7)
end

function _update()
    -- Loop music. Check if currently any music if played, if not, then play the same song again.
    if stat(54) < 0 then
        music(0)
    end

    if GameStarted then
        for b = 0, 5 do
            if btn(b) then
                GameStarted = false
            end
        end
        return
    end

    -- Check for any user input.
    Player:handle_keys()
    Player:handle_mouse()

    -- Update all buildings and bees of the player.
    Player:update()
    Pickups:update()
    camera(Cam.x, Cam.y)
end

function _draw()
    if GameStarted then
        return
    end

    AnimationTimer:inc()
    Bee.display:inc()
    if AnimationTimer.val == 0 then
        for option in BuildOptions:iter() do
            option.display:inc()
        end
    end

    cls()

    -- calculate field of view
    local fov = Rect.new{ x=Pixel2Tile(Cam.x)-2, y=Pixel2Tile(Cam.y)-2, w=18, h=18 }
    Underlay:draw(fov)
    Overlay:draw(fov)
    Player:draw()
    Pickups:draw()

    local pos = Vec2.new{ x=Tile2Pixel(Pixel2Tile(Cam.x + stat(32))), y=Tile2Pixel(Pixel2Tile(Cam.y + stat(33))) }
    rect(pos.x, pos.y, pos.x + 8, pos.y + 8, 7)

    UI:draw()
    -- draw mouse cursor
    spr(0, Cam.x + stat(32)-1, Cam.y + stat(33)-1)
end
