UI = {
  height = 3*8,
  padding = 3,
  timer = {
    width = 50,
    height = 2,
    colors = { 8, 9, 10 }
  }
}

function UI:draw()
  -- black background
  -- FIXME: rectfill(Cam.x, 128 - UI.height, Cam.x + 128, 128, 0)
  rectfill(Cam.x, 128 - UI.height, 128, 128, 0)

  -- timers
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

  -- print mode
  print(ControlMode and "CONTROL" or "BUILD", Cam.x + 100, 105, 7)

  -- draw indicator bg 
  rectfill(Cam.x + 118, 118, Cam.x + 128, 128, 7)
  -- draw current building 
  spr(BuildOptions[SelectedOption.val].icon, Cam.x + 119, 119)
end

