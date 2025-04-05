---@diagnostic disable: lowercase-global
---Offset and speed of the camera.
Cam = {
    x = 0,
    y = 0,
    speed = 5
}
ControlMode = false
---@type Worker?
SelectedWorker = nil
AnimationTimer = Cycle.new{ max=8 }

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
    if SwitchCooldown.val == 0 then
        if btn(2) then
            SelectedOption:inc()
            SwitchCooldown.val = 1
        end
        if btn(3) then
            SelectedOption:dec()
            SwitchCooldown.val = 1
        end
        if btn(4) then
            ControlMode = not ControlMode
            SwitchCooldown.val = 1
        end
    else
        SwitchCooldown:inc()
    end

    local mouse = stat(34)
    local pos = Vec2.new{
            x=Cam.x + stat(32)-1,
            y=Cam.y + stat(33)-1
    }
    if mouse > 0 then
        if ControlMode then
            -- TODO: control the hive!
            if mouse == 1 then
                -- we start by the index 1 and NOT 0, because the queen is always
                -- located at index 0 and we do not want to control or move the queen.
                SelectedWorker = nil -- deselect previously selected worker
                for i = 1, Creatures:len()-1 do
                    local creature = Creatures:get(i)
                    assert(creature ~= nil, "Creature should not be nil")
                    if creature.pos.x < pos.x and pos.x < creature.pos.x + 8
                    and creature.pos.y < pos.y and pos.y < creature.pos.y + 8 then
                        SelectedWorker = creature
                        break
                    end
                end
            elseif mouse == 2 and SelectedWorker ~= nil then
                if not btn(5) then
                    SelectedWorker.des:clear()
                end
                SelectedWorker.des:add(pos)
            end
        else
            -- current moused tile
            local tile = Vec2.new{
                    x=Pixel2Tile(pos.x),
                    y=Pixel2Tile(pos.y)
            }
            -- LMB
            if mouse == 1 then
                if Overlay:get_building(tile.x, tile.y) == nil then
                    local option = BuildOptions[SelectedOption.val]
                    -- check if there is already a building presend at the position
                    for dx = 0, option.dim.x-1 do
                        for dy = 0, option.dim.y-1 do
                            if Overlay:get_building(tile.x + dx, tile.y + dy) ~= nil then
                                -- another building is already presend, therefore we directly go to exit
                                goto exit_mouse
                            end
                        end
                    end
                    option.new(tile)
                end
            -- RMB
            elseif mouse == 2 then
                Overlay:pop_building(tile.x, tile.y)
            end
        end
    end
    ::exit_mouse::

    camera(Cam.x, Cam.y)

    Creatures:update()

    -- TODO: also check whether Queen has been fed
    -- TODO: game over checks (if timer == 0 && Queen not fed)
    -- TODO: implement a way to reattempt / Game over screen (see Game.state)
end

function _draw()
    AnimationTimer:inc()
    Worker.display:inc()
    if AnimationTimer.val == 0 then
        for option in BuildOptions:iter() do
            option.display:inc()
        end
    end

    cls()

    -- calculate field of view
    local fov = Rect.new{ x=Pixel2Tile(Cam.x)-1, w=18, h=12 }
    Underlay:draw(fov)
    Overlay:draw(fov)
    Creatures:draw()

    UI:draw()
    -- draw mouse cursor
    spr(0, Cam.x + stat(32)-1, Cam.y + stat(33)-1)
end
