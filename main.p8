pico-8 cartridge // http://www.pico-8.com
version 20
__lua__


dt = null
t = 0
function _init()

   mapView = MapView:new(Character:new(60, 60, 1, 2, 1))
   
   ticketsView = TicketsView:new()
   ticketsView:addTicket("1 bonjour, mon pc il est dead \nde ouf, c'est trop chiant\nsa mere.\n\n\n\n\n\n\n\n\n                    micheline")
   ticketsView:addTicket("2 bonjour, mon pc il est dead \nde ouf, c'est trop chiant\nsa mere")
   ticketsView:addTicket("3 bonjour, mon pc il est dead \nde ouf, c'est trop chiant\nsa mere")
   ticketsView:addTicket("4 bonjour, mon pc il est dead \nde ouf, c'est trop chiant\nsa mere")
   ticketsView:addTicket("5 bonjour, mon pc il est dead \nde ouf, c'est trop chiant\nsa mere")
   ticketsView:addTicket("6 bonjour, mon pc il est dead \nde ouf, c'est trop chiant\nsa mere")

   
   -- currentView = ticketsView
   currentView = mapView
   palt(11, true)

end

function _update60()

   -- ===============================
   -- change view test
   if (btn(4)) then -- C
      currentView = ticketsView
   end

   if (btn(5)) then -- X
      currentView = mapView
   end
   -- ===============================
   
   currentView:update()

   if(dt == null) then
      local target_fps = stat(8)
      dt = 1 / target_fps
   end

   t += flr(dt*1000)

end

function _draw()
   cls()
   currentView:draw(t)
end
