---@diagnostic disable: undefined-global, lowercase-global
-- offset of the camera
Cam = {
    x = 0,
    y = 0,
    speed = 5
}

function _init()
    -- activate dev mode
    poke(0x5f2d, 1)
end

function _update()
    if btn(0) then Cam.x = Cam.x + 1 * Cam.speed end
    if btn(1) then Cam.x = Cam.x - 1 * Cam.speed end
    -- deactivate y axis control
    -- if btn(2) then cam.y = cam.y + 1 end
    -- if btn(3) then cam.y = cam.y - 1 end

    camera(Cam.x, Cam.y)
end

function _draw()
    cls()

    GameMap:draw(Rect.new{ w=16, h=16 })
    -- map(0, 0, 0, 0, 16, 16)

    print(stat(34))

    -- draw mouse cursor
    spr(0, Cam.x + stat(32)-1, Cam.y + stat(33)-1)
end
