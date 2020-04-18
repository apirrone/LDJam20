pico-8 cartridge // http://www.pico-8.com
version 20
__lua__


dt = null
t = 0
function _init()

   mapView = MapView:new(Character:new(10, 10, 1, 2, 1))
   ticketsView = TicketsView:new()
   ticketsView:addTicket(Ticket:new("Bonjour, mon pc il est cassé"))
   
   -- currentView = ticketsView
   currentView = mapView
   palt(11, true)

end

function _update60()

   -- ===============================
   -- change view test
   if (btn(4)) then -- N
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
