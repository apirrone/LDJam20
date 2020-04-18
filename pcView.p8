
Icon = {}
function Icon:new(index, x, y, spriteId)
   local icon = setmetatable({}, { __index = Icon})

   icon.index = index
   
   icon.pos = {}
   icon.pos.x = x*40+10
   icon.pos.y = y*40+10

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
   cursor.pos.x = x
   cursor.pos.y = y

   currentIndex = 0
   
   return cursor

end


function Cursor:draw()

   tmpX = self.pos.x*40+10
   tmpY = self.pos.y*40+10
   
   pset(tmpX, tmpY, 8)
   pset(tmpX+1, tmpY, 8)
   pset(tmpX+2, tmpY, 8)
   pset(tmpX, tmpY+1, 8)
   pset(tmpX, tmpY+2, 8)
   
   pset(tmpX+7, tmpY, 8)
   pset(tmpX+6, tmpY, 8)   
   pset(tmpX+5, tmpY, 8)
   pset(tmpX+7, tmpY+1, 8)
   pset(tmpX+7, tmpY+2, 8)

   
   pset(tmpX, tmpY+7, 8)
   pset(tmpX, tmpY+6, 8)
   pset(tmpX, tmpY+5, 8)
   pset(tmpX+1, tmpY+7, 8)
   pset(tmpX+2, tmpY+7, 8)

   
   pset(tmpX+7, tmpY+7, 8)
   pset(tmpX+6, tmpY+7, 8)
   pset(tmpX+5, tmpY+7, 8)
   pset(tmpX+7, tmpY+6, 8)
   pset(tmpX+7, tmpY+5, 8)   
   
end


PcView = {}

function PcView:new()
   local pcView = setmetatable({}, { __index = PcView})
   
   pcView.icons = {}

   add(pcView.icons, Icon:new(#pcView.icons+1, 0, 0, 192))
   add(pcView.icons, Icon:new(#pcView.icons+1, 1, 0, 193))
   add(pcView.icons, Icon:new(#pcView.icons+1, 2, 0, 194))
   add(pcView.icons, Icon:new(#pcView.icons+1, 0, 1, 198))
   add(pcView.icons, Icon:new(#pcView.icons+1, 1, 1, 199))
   add(pcView.icons, Icon:new(#pcView.icons+1, 2, 1, 200))
   add(pcView.icons, Icon:new(#pcView.icons+1, 0, 2, 201))
   add(pcView.icons, Icon:new(#pcView.icons+1, 1, 2, 195))

   pcView.cursor = Cursor:new(0, 0)

   -- 0 : desktop
   -- 1 : fichiers
   -- 8 : settings
   -- ?????
   pcView.displayState = 0 

   pcView.settings = {}
   pcView.settings.internet = true
   pcView.settings.hard_drive = true
   pcView.settings.cpu = true
   pcView.settings.vernum = true
   pcView.settings.keyboard_layout_qwerty = true
   pcView.settings.inverted_screen = true

   
   


   
   return pcView
end

function PcView:isValidPos(x, y)
   
   retVal = false
   for v in all(self.icons) do
      if v.pos.x == (x*40+10) and v.pos.y == (y*40+10) then
	 retVal = v.index
      end
   end

   return retVal
end

function PcView:update()
   
   newPos = {}
   newPos.x = pcView.cursor.pos.x
   newPos.y = pcView.cursor.pos.y
   
   if (btnp(⬆️)) then
      newPos.y -= 1
   elseif (btnp(⬇️)) then
      newPos.y += 1
   end

   if (btnp(⬅️)) then
      newPos.x -= 1
   elseif (btnp(➡️)) then
      newPos.x += 1
   end

   
   tmpIndex = self:isValidPos(newPos.x, newPos.y)
   if tmpIndex then
      pcView.cursor.pos = newPos
      self.cursor.currentIndex = tmpIndex
   end
   
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
   
   rectfill(6, 114, 121, 121, 5)

   print("lucarne 98", 82, 108, 2)

   self.cursor:draw()
   print(self.cursor.currentIndex, 0, 0)
   
end

