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
    if btn(4) then SelectedOption = (SelectedOption + 1) % BuildOptions:len() end
    if btn(5) then SelectedOption = (SelectedOption + BuildOptions:len() - 1) % BuildOptions:len() end

    if stat(34) > 0 then
        GameMap:set_field(Vec2.new{
            x=Pixel2Tile(Cam.x + stat(32)-1),
            y=Pixel2Tile(Cam.y + stat(33)-1)
        }, BuildOptions[SelectedOption])
    end

    camera(Cam.x, Cam.y)
end

function _draw()
    cls()

    GameMap:draw(Rect.new{ x=Pixel2Tile(Cam.x), w=18, h=16 })
    -- map(0, 0, 0, 0, 16, 16)

    -- draw mouse cursor
    spr(0, Cam.x + stat(32)-1, Cam.y + stat(33)-1)
end
