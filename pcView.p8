Cursor = {}

function Cursor:new()
   local cursor = setmetatable({}, { __index = Cursor})
   
   cursor.pos = 0
   
   return cursor

end

function Cursor:draw()
   
   
   
end



PcView = {}

function PcView:new()
   local pcView = setmetatable({}, { __index = PcView})

   pcView.items = {}
   
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

   spr(145, 10, 10, 1, 1)
   spr(145, 40, 10, 1, 1)
   spr(145, 70, 10, 1, 1)
   spr(145, 10, 30, 1, 1)
   spr(145, 40, 30, 1, 1)
   spr(145, 70, 30, 1, 1)

   
   rectfill(6, 114, 121, 121, 5)

   print("lucarne 98", 82, 108, 2)
   
   
end

