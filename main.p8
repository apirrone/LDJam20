pico-8 cartridge // http://www.pico-8.com
version 20
__lua__


dt = null
t = 0
function _init()
   
   views = {}
   
   views.mainView = View:new()
   views.mainView:addComponent(Character:new(10, 10, 1, 2, 1))
   
   -- En vrai il faudrait faire de l'héritage avec la classe view, mais j'ai la flemme de chercher comment faire. Todo à celui qui a la foi
   views.ticketsView = TicketsView:new()
   views.ticketsView:addTicket(Ticket:new("Bonjour, mon pc il est cassé"))
   
   
   currentView = views.ticketsView
   -- currentView = views.mainView
end

function _update60()

   -- ===============================
   -- change view test
   if (btn(4)) then -- N
      currentView = views.ticketsView
   end

   if (btn(5)) then -- X
      currentView = views.mainView
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
