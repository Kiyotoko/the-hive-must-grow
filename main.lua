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
    if btn(0) then Cam.x = Cam.x - Cam.speed end
    if btn(1) then Cam.x = Cam.x + Cam.speed end
    -- deactivate y axis control
    -- if btn(2) then cam.y = cam.y + 1 end
    -- if btn(3) then cam.y = cam.y - 1 end
    if SwitchCooldown.val == 0 then
        if btn(4) then
            SelectedOption:inc()
            SwitchCooldown.val = 1
        end
        if btn(5) then
            SelectedOption:dec()
            SwitchCooldown.val = 1
        end
    else
        SwitchCooldown:inc()
    end

    local mouse = stat(34)
    if mouse > 0 then
        -- current moused tile
        local tile = Vec2.new{
                x=Pixel2Tile(Cam.x + stat(32)-1),
                y=Pixel2Tile(Cam.y + stat(33)-1)
        }
        -- LMB
        if mouse == 1 then
            if Overlay:get_building(tile.x, tile.y) == nil then
                local factory = BuildOptions[SelectedOption.val].new
                factory(tile)
            end
        -- RMB
        elseif mouse == 2 then
            Overlay:pop_building(tile.x, tile.y)
        end
    end

    camera(Cam.x, Cam.y)

    Entities:update()

    Building.icon.timer:inc()
    if Building.icon.timer.val == 0 then
        Building.icon.display:inc()
    end

    Drill.timer:inc()
    if Drill.timer.val == 0 then
        Drill.display:inc()
    end

    -- TODO: also check whether Queen has been fed
    -- TODO: game over checks (if timer == 0 && Queen not fed)
    -- TODO: implement a way to reattempt / Game over screen (see Game.state)
end

function _draw()
    cls()

    -- calculate field of view
    local fov = Rect.new{ x=Pixel2Tile(Cam.x)-1, w=18, h=12 }
    Underlay:draw(fov)
    Overlay:draw(fov)
    Queen:draw()

    UI:draw()
    -- draw mouse cursor
    spr(0, Cam.x + stat(32)-1, Cam.y + stat(33)-1)
end
