UI = {
  height = 12
}

function UI:draw()
  print("LVL:   " .. Player.lvl, Cam.x+1, Cam.y+1, 7)
  print("XP:    " .. Player.xp)
  print("STONE: " .. Player.inv.stone)
  print("WOOD:  " .. Player.inv.wood)
  print("HONEY: " .. Player.inv.honey)
  -- black background
  rectfill(Cam.x, Cam.y + 128 - UI.height, Cam.x + 128, Cam.y + 128, 0)

  --[[
  local step = flr((UI.height - 2 * UI.padding) / #Queen.goals)
  local counter = 0
  for i = 1, #Queen.goals do
    local pos = { -- top left corner of timer
      x = Cam.x + UI.padding,
      y = 128 - UI.height + UI.padding + counter * step
    }
    -- timer label
    print(Queen.goal_names[i], pos.x + UI.timer.width + UI.padding, pos.y-2, UI.timer.colors[i] or 3)

    -- timer
    rectfill(
      pos.x, pos.y,
      pos.x + UI.timer.width - flr(UI.timer.width * (Queen.goals[i].val / Queen.goals[i].max)), pos.y + UI.timer.height,
      UI.timer.colors[i] or 3
    )
    counter = counter + 1
  end
  ]]

  local building = BuildOptions[SelectedOption.val]

  -- print mode
  print(ControlMode and "CONTROL" or "BUILD", Cam.x + 5, Cam.y + 122, 7)
  if not ControlMode then
    print("S: " .. building.price.stone .. " W: " .. building.price.wood .. " H: " .. building.price.honey, Cam.x + 65, Cam.y + 121, 7)
    -- draw indicator bg 
    rectfill(Cam.x + 50, Cam.y + 118, Cam.x + 59, Cam.y + 127, 7)
    -- draw current building 
    spr(building.icon, Cam.x + 51, Cam.y + 119)
  end
end
