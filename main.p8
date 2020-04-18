pico-8 cartridge // http://www.pico-8.com
version 20
__lua__


dt = null
t = 0

-- =======================
-- DEBUG
viewCycle = 2
nbViews = 3
-- =======================
function _init()

   mapView = MapView:new(Character:new(60, 60, 1, 2, 1))
   
   ticketsView = TicketsView:new()
   ticketsView:addTicket("1 bonjour, mon pc il est dead \nde ouf, c'est trop chiant\nsa mere.\n\n\n\n\n\n\n\n\n                    micheline")
   ticketsView:addTicket("2 bonjour, mon pc il est dead \nde ouf, c'est trop chiant\nsa mere")
   ticketsView:addTicket("3 bonjour, mon pc il est dead \nde ouf, c'est trop chiant\nsa mere")
   ticketsView:addTicket("4 bonjour, mon pc il est dead \nde ouf, c'est trop chiant\nsa mere")
   ticketsView:addTicket("5 bonjour, mon pc il est dead \nde ouf, c'est trop chiant\nsa mere")
   ticketsView:addTicket("6 bonjour, mon pc il est dead \nde ouf, c'est trop chiant\nsa mere")

   pcView = PcView:new()
   
   palt(11, true)

end

function _update60()
   

   if(dt == null) then
      local target_fps = stat(8)
      dt = 1 / target_fps
   end

   t += flr(dt*1000)

   

   -- ===============================
   -- change view test
   if (btnp(4)) then -- C
      viewCycle = (viewCycle+1)%nbViews
   end

   if viewCycle == 0 then
      currentView = mapView
   elseif viewCycle == 1 then
      currentView = ticketsView
   elseif viewCycle == 2 then
      currentView = pcView
   end
   -- ===============================

   -- if (btnp(5)) then -- X
   --    currentView = mapView
   -- end
   
   currentView:update()


end

function _draw()
   cls()
   currentView:draw(t)
end
