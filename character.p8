pico-8 cartridge // http://www.pico-8.com
version 20
__lua__


Character = Drawable:new()

function Character:new(x, y, w, h, speed)

   local character = Drawable:new(x,y,w,h)
   self.__index = self
   setmetatable(character, self)

   character.speed = speed

   character.animations = {}

   character.animations.walkRightAnimation = Animation:new(4, 0, character.size, 20, false)
   character.animations.walkRightAnimation:setCycle(3, {0, 2, 3})

   character.animations.walkLeftAnimation = Animation:new(4, 0, character.size, 20, true)
   character.animations.walkLeftAnimation:setCycle(3, {0, 2, 3})

   character.animations.walkUpRightAnimation = Animation:new(4, 0, character.size, 20, false)
   character.animations.walkUpRightAnimation:setCycle(3, {4, 6, 7})

   character.animations.walkUpLeftAnimation = Animation:new(4, 0, character.size, 20, true)
   character.animations.walkUpLeftAnimation:setCycle(3, {4, 6, 7})

   character.currentAnimation = character.animations.walkRightAnimation
   return character
end

function is_wall(x,y)
   return fget(mget(x,y), 7)
end

function collide_wall(hitbox)
   x0 = flr(hitbox.x0/8)
   y0 = flr(hitbox.y0/8)
   x1 = flr(hitbox.x1/8)
   y1 = flr(hitbox.y1/8)


   return is_wall(x0,y0) or is_wall(x0, y1) or is_wall(x1,y0) or is_wall(x1,y1)
end

function Character:update()

   local move_x = 0
   local move_y = 0

   if (btn(⬅️)) then
      move_x += -self.speed
   end
   if (btn(➡️)) then
      move_x += self.speed
   end

   if (btn(⬆️)) then
      move_y += -self.speed
   end
   if (btn(⬇️)) then
      move_y += self.speed
   end

   if (move_x != 0 or move_y != 0) then
      self.currentAnimation.freeze = false
   end


   if (move_x < 0 and move_y < 0) then
      self.currentAnimation = self.animations.walkUpLeftAnimation
   elseif (move_x > 0 and move_y < 0) then
      self.currentAnimation = self.animations.walkUpRightAnimation
   elseif (move_x < 0) then
      self.currentAnimation = self.animations.walkLeftAnimation
   elseif (move_x > 0) then
      self.currentAnimation = self.animations.walkRightAnimation
   elseif (move_y < 0 ) then
      self.currentAnimation = self.animations.walkUpRightAnimation
   elseif (move_y == 0) then
      self.currentAnimation.freeze = true
   end

   self:move(move_x, move_y)
end

function Character:move(x, y)
   new_x = self.pos.x + x
   new_y = self.pos.y + y


   hitbox = { x0 = new_x +1 , y0 = new_y + 13, x1 = new_x + 7, y1 = new_y + 15}

   if not(collide_wall(hitbox)) then
      self.pos.x += x
      self.pos.y += y
   end
end

function Character:setPos(x, y)
   self.pos.x = x
   self.pos.y = y
end


function Character:draw(t)
   self.currentAnimation:draw(self.pos, t)

   -- DEBUG
   hitbox = { x0 = new_x +1 , y0 = new_y + 13, x1 = new_x + 7, y1 = new_y + 15}
   rect(hitbox.x0, hitbox.y0, hitbox.x1, hitbox.y1)
end
