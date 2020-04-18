Animation = {}

function Animation:new(cycleSize, startPos, spriteSize, speed, flip)
   local animation = setmetatable({}, { __index = Animation})

   animation.cycleSize = cycleSize
   animation.startPos = startPos
   animation.size = spriteSize
   animation.speed = speed
   animation.flip = flip

   animation.currentCyclePos = 0
   animation.freeze = false

   animation.cycle = {}
   for i=0, cycleSize,1 do
      animation.cycle[i] = i
   end
   
   return animation
end

function Animation:setCycle(cycleSize, positions)
   self.cycleSize = cycleSize
   self.cycle = {}
   
   i = 0
   for v in all(positions) do
      self.cycle[i] = v
      i+=1
   end

end

function Animation:draw(pos, t)
   
   if (self.freeze) then
      self.currentCyclePos = 0
   end
   
   spr(self.cycle[self.currentCyclePos]*self.size.w, pos.x, pos.y, self.size.w, self.size.h, self.flip)
   if ((t%self.speed == 0) and  (self.freeze == false)) then
      self.currentCyclePos = (self.currentCyclePos+1)%self.cycleSize
   end
end


