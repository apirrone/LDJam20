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
   ticketId = ticketsView:addTicket("1 bonjour, mon pc il est dead \nde ouf, c'est trop chiant\nsa mere.\n\n\n\n\n\n\n\n\n                    micheline")
   -- ticketsView:addTicket("2 bonjour, mon pc il est dead \nde ouf, c'est trop chiant\nsa mere")
   -- ticketsView:addTicket("3 bonjour, mon pc il est dead \nde ouf, c'est trop chiant\nsa mere")
   -- ticketsView:addTicket("4 bonjour, mon pc il est dead \nde ouf, c'est trop chiant\nsa mere")
   -- ticketsView:addTicket("5 bonjour, mon pc il est dead \nde ouf, c'est trop chiant\nsa mere")
   -- ticketsView:addTicket("6 bonjour, mon pc il est dead \nde ouf, c'est trop chiant\nsa mere")


   pc_coords = mapView:scan_pcs()
   pc_list = {}
   for a,b in ipairs(pc_coords) do
      for i,v in pairs(b) do
         printh(i.." "..v)
      end
      add(pc_list, PC:new(b.x, b.y, rnd(TOTAL_NB_ISSUES)))
      printh("-")
   end

   current_pc = pc_list[1]
   pcView = PcView:new(current_pc.issues)

   currentView = mapView

   palt(11, true)
   palt(0, false)

end

function _update60()


   if(dt == null) then
      local target_fps = stat(8)
      dt = 1 / target_fps
   end

   t += flr(dt*1000)



   -- ===============================
   -- change view test

   -- oldView = currentView
   -- if (btnp(4)) then -- C

   --    viewCycle = (viewCycle+1)%nbViews
   --    if viewCycle == 0 then
   -- 	 currentView = mapView
   --    elseif viewCycle == 1 then
   -- 	 currentView = ticketsView
   --    elseif viewCycle == 2 then
   -- 	 currentView = pcView
   --    end

   -- end

   if(currentView == mapView) then
      toggle_pc = mapView:toggle_pc()
      if(toggle_pc.val) then
         currentView = pcView
         camera(0,0)

         printh("PC pos "..toggle_pc.coords.x.." "..toggle_pc.coords.y)
         for i = 1, #pc_list do
            if(pc_list[i].pos.x == toggle_pc.coords.x and pc_list[i].pos.y == toggle_pc.coords.y) then
               pcView:loadIssues(current_pc.issues)
               printh("Trouve")
            end
         end
      end
   end

   -- if currentView != oldView then
   --    camera(0,0)
   -- end
   -- ===============================

   return_value = currentView:update()

   if return_value == -1 then
      currentView = mapView
      camera(0,0)
   end


end

function _draw()
   cls()
   currentView:draw(t)
end
