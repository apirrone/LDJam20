pico-8 cartridge // http://www.pico-8.com
version 18
__lua__

#include character.p8
#include animation.p8

dt = null
t = 0
function _init()
   character = Character:new(10, 10, 1, 2, 1)
end

function _update60()
   character:handleInputs()

   if(dt == null) then
      local target_fps = stat(8)
      dt = 1 / target_fps
   end

   t += flr(dt*1000)

end

function _draw()
   cls()
   -- print("t: " .. t)
   character:draw(t)
end
