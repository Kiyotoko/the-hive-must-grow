---@diagnostic disable: lowercase-global
-- offset of the camera
Cam = {
    x = 0,
    y = 0,
    speed = 5
}

function _init()
    -- activate dev mode
    poke(0x5f2d, 1)
    -- change transparency color
    palt(15, true)
    palt(0, false)
end

function _update()
    if btn(0) then Cam.x = Cam.x - 1 * Cam.speed end
    if btn(1) then Cam.x = Cam.x + 1 * Cam.speed end
    -- deactivate y axis control
    -- if btn(2) then cam.y = cam.y + 1 end
    -- if btn(3) then cam.y = cam.y - 1 end
    if btn(4) then SelectedOption:inc() end
    if btn(5) then SelectedOption:dec() end

    local mouse = stat(34)
    if mouse > 0 then
        local tile = Vec2.new{
            x=Pixel2Tile(Cam.x + stat(32)-1),
            y=Pixel2Tile(Cam.y + stat(33)-1)
        }
        if mouse == 1 then
            local factory = BuildOptions[SelectedOption.val]
            factory(tile)
        else
            Overlay:pop_building(tile.x, tile.y)
        end
    end

    camera(Cam.x, Cam.y)

    Belt.timer:inc()
    if Belt.timer.val == 0 then
        Belt.display:inc()
    end
end

function _draw()
    cls()

    -- calculate field of view
    local fov = Rect.new{ x=Pixel2Tile(Cam.x), w=18, h=16 }
    Underlay:draw(fov)
    Overlay:draw(fov)

    -- draw mouse cursor
    spr(0, Cam.x + stat(32)-1, Cam.y + stat(33)-1)
end
