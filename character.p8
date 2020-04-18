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


function Character:collide_wall(x,y)
   grid_x = flr(x/8)
   grid_y = flr(y/8)


   return (fget(mget(grid_x,grid_y), 7))
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
   check_x = self.pos.x + x
   check_y = self.pos.y + y

   if (x > 0) check_x += 8 // Check of the right if going right
   check_y += 14 // We only check the foot

   if not(self:collide_wall(check_x, check_y)) then
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
end
