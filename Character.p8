Character = {}

function Character:new(x, y, w, h, speed)
   local character = setmetatable({}, { __index = Character })

   character.pos = {}
   character.pos.x = x
   character.pos.y = y

   character.size = {}
   character.size.w = w
   character.size.h = h

   character.speed = speed
   
   return character
end

function Character:handleInputs()
   
   local move_x = 0
   local move_y = 0
   
   if (btn(⬅️)) then
      move_x = -self.speed
   elseif (btn(➡️)) then
      move_x = self.speed
      
   end
   if (btn(⬆️)) then
      move_y = -self.speed
   elseif (btn(⬇️)) then
      move_y = self.speed
   end

   self:move(move_x, move_y)
   
end

function Character:move(x, y)
   self.pos.x += x
   self.pos.y += y
end

function Character:setPos(x, y)
   self.pos.x = x
   self.pos.y = y
end


function Character:draw()
   spr(0, self.pos.x, self.pos.y, self.size.w, self.size.h)
end
