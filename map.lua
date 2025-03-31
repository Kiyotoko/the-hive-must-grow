-- offset of the camera
cam = {
    x = 0,
    y = 0,
    speed = 5
}

function _init()
    -- activate dev mode
    poke(0x5f2d, 1)
end

function _update()
    if btn(0) then cam.x = cam.x + 1 * cam.speed end
    if btn(1) then cam.x = cam.x - 1 * cam.speed end
    -- deactivate y axis control
    -- if btn(2) then cam.y = cam.y + 1 end
    -- if btn(3) then cam.y = cam.y - 1 end

    camera(cam.x, cam.y)
end

function _draw()
    cls()

    map(0, 0, 0, 0, 16, 16)

    print(stat(34))

    -- draw mouse cursor
    spr(0, cam.x + stat(32)-1, cam.y + stat(33)-1)
end
