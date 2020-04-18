pico-8 cartridge // http://www.pico-8.com
version 18
__lua__

#include Character.p8

function _init()
   character = Character:new(10, 10, 2, 2, 2)
end

function _update()
   character:handleInputs()

   
end

function _draw()
   cls()
   character:draw()
end
