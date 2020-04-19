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

function is_flag(x,y, flag)
   return fget(mget(x,y), flag)
end

function is_wall(x,y)
   return is_flag(x,y, 7)
end

function is_pc(x,y)
   return is_flag(x,y, 6)
end

function is_chair(x,y)
   return is_flag(x,y, 5)
end

function collide_flag(hitbox, flag)
   x0 = flr(hitbox.x0/8)
   y0 = flr(hitbox.y0/8)
   x1 = flr(hitbox.x1/8)
   y1 = flr(hitbox.y1/8)

   retval = {val=false, coords={x=0, y=0} }

   retval.val =  is_flag(x0,y0, flag) or is_flag(x0,y1, flag) or is_flag(x1,y0, flag) or is_flag(x1,y1, flag)

   if(retval.val) then
      if is_flag(x0,y0, flag) then retval.coords = {x=x0,y=y0} end
      if is_flag(x0,y1, flag) then retval.coords = {x=x0,y=y1} end
      if is_flag(x1,y0, flag) then retval.coords = {x=x1,y=y0} end
      if is_flag(x1,y1, flag) then retval.coords = {x=x1,y=y1} end
   end

   return retval
end

function collide_wall(hitbox)
   return collide_flag(hitbox,7).val
end

function Character:in_front_pc()

   retval = {val = false, coords = {x=0, y=0}}
   if(self.currentAnimation == self.animations.walkRightAnimation) then
      hitbox = { x0 = self.pos.x +1 , y0 = self.pos.y + 13, x1 = self.pos.x + 7, y1 = self.pos.y + 15}
      retval =  collide_flag(hitbox, 5)
      if(retval.val) then
         retval.coords = {x= retval.coords.x + 1, y=retval.coords.y - 1} -- chair to PC
      end
   end

    return retval
end

function Character:update(mapView)

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

   self:move(move_x, move_y, mapView.size)
end

function Character:move(x, y, bounds)
   new_x = self.pos.x + x
   new_y = self.pos.y + y

   new_x = min(max(new_x, 0), bounds.w)
   new_y = min(max(new_y, 0), bounds.h)

   hitbox_x = { x0 = new_x +1 , y0 = self.pos.y + 13, x1 = new_x + 7, y1 = self.pos.y + 15}
   hitbox_y = { x0 = self.pos.x +1 , y0 = new_y + 13, x1 = self.pos.x + 7, y1 = new_y + 15}

   if not(collide_wall(hitbox_x)) then self.pos.x = new_x end
   if not(collide_wall(hitbox_y)) then self.pos.y = new_y end

end

function Character:setPos(x, y)
   self.pos.x = x
   self.pos.y = y
end


function Character:draw(t)
   self.currentAnimation:draw(self.pos, t)

   -- DEBUG
   hitbox = { x0 = new_x +1 , y0 = new_y + 13, x1 = new_x + 7, y1 = new_y + 15}
   rect(hitbox.x0, hitbox.y0, hitbox.x1, hitbox.y1, 15)
end
