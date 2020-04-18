Animation = {}

function Animation:new(cycleSize, startPos, spriteSize, speed, flip)
   local animation = setmetatable({}, { __index = Animation})

   animation.cycleSize = cycleSize
   animation.startPos = startPos
   animation.size = spriteSize
   animation.speed = speed
   animation.flip = flip

   animation.currentPos = 0
   animation.freeze = false
   return animation
end

function Animation:draw(pos, t)
   if (self.freeze) then
      self.currentPos = 0
   end
   
   spr(self.currentPos, pos.x, pos.y, self.size.w, self.size.h, self.flip)
   if ((t%self.speed == 0) and  (self.freeze == false)) then
      self.currentPos = (self.currentPos+self.size.w)%(self.cycleSize*self.size.w)
   end
end


