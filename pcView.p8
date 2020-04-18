Icon = {}
function Icon:new(index, x, y, spriteId)
   local icon = setmetatable({}, { __index = Icon})

   icon.index = index
   
   icon.pos = {}
   icon.pos.x = x
   icon.pos.y = y

   icon.spriteId = spriteId
   return icon

end

function Icon:draw()
   spr(self.spriteId, self.pos.x, self.pos.y, 1, 1)
end



Cursor = {}

function Cursor:new(x, y)
   local cursor = setmetatable({}, { __index = Cursor})
   
   cursor.pos = {}
   cursor.pos.x = x, y
   cursor.pos.y = 10
   
   return cursor

end

function Cursor:draw()

   pset(self.pos.x, self.pos.y, 8)
   pset(self.pos.x+1, self.pos.y, 8)
   pset(self.pos.x+2, self.pos.y, 8)
   pset(self.pos.x, self.pos.y+1, 8)
   pset(self.pos.x, self.pos.y+2, 8)
   
   pset(self.pos.x+7, self.pos.y, 8)
   pset(self.pos.x+6, self.pos.y, 8)   
   pset(self.pos.x+5, self.pos.y, 8)
   pset(self.pos.x+7, self.pos.y+1, 8)
   pset(self.pos.x+7, self.pos.y+2, 8)

   
   pset(self.pos.x, self.pos.y+7, 8)
   pset(self.pos.x, self.pos.y+6, 8)
   pset(self.pos.x, self.pos.y+5, 8)
   pset(self.pos.x+1, self.pos.y+7, 8)
   pset(self.pos.x+2, self.pos.y+7, 8)

   
   pset(self.pos.x+7, self.pos.y+7, 8)
   pset(self.pos.x+6, self.pos.y+7, 8)
   pset(self.pos.x+5, self.pos.y+7, 8)
   pset(self.pos.x+7, self.pos.y+6, 8)
   pset(self.pos.x+7, self.pos.y+5, 8)
   
   
end



PcView = {}

function PcView:new()
   local pcView = setmetatable({}, { __index = PcView})

   pcView.icons = {}

   add(pcView.icons, Icon:new(#pcView.icons, 10, 10, 145))
   add(pcView.icons, Icon:new(#pcView.icons, 40, 40, 145))

   pcView.cursor = Cursor:new(10, 10)
   
   return pcView
end


function PcView:update()
   
   -- if (btn(⬆️)) then

   -- elseif (btn(⬇️)) then

   -- else
      
   -- end

   -- if (btn(⬅️)) then

   -- elseif (btn(➡️)) then

   -- end
   
   
end

function PcView:draw(t)
   rectfill(0, 0, 127, 127, 1)
   
   for i=0, 5, 1 do
      rect(i, i, 127-i, 127-i, 6)
   end
   
   rectfill(39, 124, 89, 125, 0)

   for v in all(self.icons) do
      v:draw()
   end
      
   
   -- spr(145, 10, 10, 1, 1)
   -- spr(145, 40, 10, 1, 1)
   -- spr(145, 70, 10, 1, 1)
   -- spr(145, 10, 30, 1, 1)
   -- spr(145, 40, 30, 1, 1)
   -- spr(145, 70, 30, 1, 1)

   
   rectfill(6, 114, 121, 121, 5)

   print("lucarne 98", 82, 108, 2)

   self.cursor:draw()
   
   
end

