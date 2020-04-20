pico-8 cartridge // http://www.pico-8.com
version 20
__lua__


dt = null
t = 0

function _init()
   
   currentDay = 1
   startDay()
   
end

function startDay()
   t = 0
   mapView = MapView:new(Character:new(60, 60, 1, 2, 1))

   ticketsView = TicketsView:new()


   pc_coords = mapView:scan_pcs()
   pc_list = {}
   for a,b in ipairs(pc_coords) do

      new_pc = PC:new(b.x, b.y, rnd(TOTAL_NB_ISSUES))
      add(pc_list,new_pc )

      if flr(rnd(10)) == 0 then
	 ticketId = ticketsView:addTicket("bonjour, mon pc il est \ndead de ouf, c'est trop\nchiant sa mere.\n\n\n\n\n\n\n\n\n                    micheline", new_pc)
      end

   end

   current_pc = pc_list[1]
   pcView = PcView:new(current_pc.issues)

   currentView = mapView

   palt(11, true)
   palt(0, false)

   productivity = 0
   moneyGoal = 100
   currentMoney = 0
   dayDuration = 50 -- seconds
   gameOver = false
end

function _update60()


   if(dt == null) then
      local target_fps = stat(8)
      dt = 1 / target_fps
   end

   t += dt -- in s

   if gameOver then
      return 0
   end
   
   oldView = currentView

   if(currentView == mapView) then
      if(btnp(5)) then
         toggle_pc = mapView:can_toggle_pc()
         if(toggle_pc.val) then
            currentView = pcView

            -- printh("PC pos "..toggle_pc.coords.x.." "..toggle_pc.coords.y)
            for i = 1, #pc_list do
               if(pc_list[i].pos.x == toggle_pc.coords.x and pc_list[i].pos.y == toggle_pc.coords.y) then
                  current_pc = pc_list[i]
                  pcView:loadIssues(current_pc.issues)
                  -- printh("Trouve")
               end
            end
         end
      elseif(btnp(4)) then
         currentView = ticketsView
      end
   end


   if(currentView == oldView) then
      return_value = currentView:update(t)

      if return_value == -1 then
         current_pc.issues = pcView.issues
         currentView = mapView
      end
   else
      camera(0,0)
   end


   productivity = 1-(#ticketsView.tickets/#pc_list)

   -- if flr(t)%2 == 0 then
   currentMoney += productivity*0.1
   -- end
   printh(t)
   if t> dayDuration then
      if currentMoney >= moneyGoal then
	 currentDay += 1
	 startDay()
      else
	 gameOver = true	 
      end
   end

end

function _draw()
   cls()
   if not gameOver then
      currentView:draw(t, productivity, currentMoney, moneyGoal, dayDuration)
   else
      print("game over", 40, 50, 1)
   end
end
