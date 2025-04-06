UI = {
    height = 12
}

function UI:draw()
    print("lvl: " .. Player.lvl, Cam.x+90, Cam.y+1, 7)
    print("xp:  " .. Player.xp)
    print("stone: " .. Player.inv.stone, Cam.x+1, Cam.y+1)
    print("wood:  " .. Player.inv.wood)
    print("honey: " .. Player.inv.honey)

    -- the building that is currently selected
    local building = BuildOptions[SelectedOption.val]

    -- black background
    rectfill(Cam.x, Cam.y + 128 - UI.height, Cam.x + 128, Cam.y + 128, 0)
    if not ControlMode then
        -- draw indicator bg 
        rectfill(Cam.x + 50, Cam.y + 118, Cam.x + 59, Cam.y + 127, 1)
        -- draw current building 
        spr(building.icon, Cam.x + 51, Cam.y + 119)
    end
    map(0, 12, Cam.x, Cam.y + 112, 16, 1)

    -- print mode
    print(ControlMode and "control" or "build", Cam.x + 5, Cam.y + 122, 7)
    if not ControlMode then
        print("s: " .. building.price.stone .. " w: " .. building.price.wood .. " h: " .. building.price.honey, Cam.x + 65, Cam.y + 121, 7)
    end
end
