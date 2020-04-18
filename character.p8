
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

   character.animations = {}
   character.animations.walkRightAnimation = Animation:new(4, 0, character.size, 20, false)
   character.animations.walkLeftAnimation = Animation:new(4, 0, character.size, 20, true)
   character.animations.idleAnimationRight = Animation:new(1, 0, character.size, 20, false)
   character.animations.idleAnimationLeft = Animation:new(1, 0, character.size, 20, true)
   character.currentAnimation = character.animations.walkRightAnimation
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

   if (move_x != 0 or move_y != 0) then
      character.currentAnimation.freeze = false
   end
   
   if (move_x < 0) then
      character.currentAnimation = character.animations.walkLeftAnimation
   elseif (move_x > 0) then
      character.currentAnimation = character.animations.walkRightAnimation
   elseif (move_y == 0) then
      character.currentAnimation.freeze = true
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


function Character:draw(t)
   self.currentAnimation:draw(self.pos, t)
end
