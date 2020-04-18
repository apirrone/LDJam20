Animation = {}

function Animation:new(cycleSize, startPos, spriteSize, speed)
   local animation = setmetatable({}, { __index = Animation})

   animation.cycleSize = cycleSize
   animation.startPos = startPos
   animation.size = spriteSize
   animation.speed = speed
   
   animation.currentPos = 0
   
   return animation
end



function Animation:draw(pos, t)
   spr(self.currentPos, pos.x, pos.y, self.size.w, self.size.h)
   if (t%self.speed == 0) then
      self.currentPos = (self.currentPos+self.size.w)%(self.cycleSize*self.size.w)
   end
end


