debug = 0
Terrain = {
  chunk = {w = 128, h = 104},
  chunks = {},
  chunkmap = {},
  smoothing = 3,
  current = {},
  dx = 8
}

-- generate a list of random integers
function Terrain:nextChunk()
end

-- smooth out the randomly generated number list
function Terrain:median()
  for _ = 1, self.smoothing do
    for x=self.dx, self.chunk.w - self.dx, self.dx do
      for y=self.dx, self.chunk.h - self.dx, self.dx do
        self.terrain[x][y] = flr((
          self.terrain[x-self.dx][y] + self.terrain[x-self.dx][y-self.dx] + self.terrain[x][y-self.dx] +
          self.terrain[x+self.dx][y] + self.terrain[x+self.dx][y+self.dx] + self.terrain[x][y+self.dx] +
          self.terrain[x+self.dx][y-self.dx] + self.terrain[x-self.dx][y+self.dx]
        )/8)
      end
    end
  end
end

-- create a new chunk
function Terrain:newChunk(x)
  self.gen_List(self)
  self.median(self)
  self.chunks[x]=self.terrain
end

-- return the index of the 2 chunks closest to x
function Terrain:getChunks(x)
  local main, side = flr(x/self.chunk.w)
  if x > (main + 0.5) * self.chunk.w then
    side = main + 1
  else
    side = main - 1
  end
  return {main * self.chunk.w, side * self.chunk.w}
end

function Terrain:init()
self.newChunk(self, 0)
self.newChunk(self, 128)
self.current = {0, 128}
end


-- check if we need a new chunk
function Terrain:update(x)
  debug = ""
  debug = debug .. "\n" .. "x = " .. x
  self.current = self.getChunks(self, x)
  local c1, c2 = self.current[1], self.current[2]
  debug = debug .. "\n" .. "c1, c2 = {" .. c1 .. ", " .. c2 .. "}"
  debug = debug .. "\n" .. "chunks[c1, c2] = \n{" .. tostring(self.chunks[c1]) .. ", " .. tostring(self.chunks[c2]) .. "}"
  if self.chunks[c2] == nil then
    self:newChunk(c2)
  end
end

function Terrain:draw(fov)
  for i = 1, 2 do
    for x, _ in pairs(self.chunks[self.current[i]]) do
      for y, v in pairs(self.chunks[self.current[i]][x]) do
        if v>25 then
          spr(10, self.current[i]+x,y)
        end
      end
    end
  end
end


function MinList(list)
local m = list[1]
for i = 1, #list  do
  m = (m < list[i]) and m or list[i]
end
return m
end

function Distance(x, y)
  x,y = x or 0, y or 0
  return abs(x-y)
end

function Terrain:inChunk(c, x)
  return c<x and x<c+self.chunk.w
end
