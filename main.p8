pico-8 cartridge // http://www.pico-8.com
version 20
__lua__


dt = null
t = 0

function is_all_ok(issues)
   all_ok = true
   for i in all(issues) do
      if i == 0 then
         all_ok = false
      end
   end

   return all_ok
end


function _init()

   palt(11, true)
   palt(0, false)

   mainMenuView = MainMenuView:new()
   currentView = mainMenuView
   currentDay = 1
   -- startDay()
end

function startDay()
   t = 0
   mapView = MapView:new(Character:new(60, 60, 1, 2, 1))

   ticketsView = TicketsView:new()

   MAX_TICKETS_PER_DAY = 10
   nb_tickets =  flr(rnd(MAX_TICKETS_PER_DAY -1)) +1




   pc_coords = mapView:scan_pcs()
   pc_list = {}
   for a,b in ipairs(pc_coords) do
      new_pc = PC:new(b.x, b.y, 0)
      add(pc_list,new_pc )
   end

   for i = 1,nb_tickets do
      repeat
         issued_pc = pc_list[flr(rnd(#pc_list)) +1]
      until is_all_ok(issued_pc.issues)

      issued_pc:newIssues(flr(rnd(TOTAL_NB_ISSUES -1)) +1)
      ticketId = ticketsView:addTicket("bonjour, mon pc il est \ndead de ouf, c'est trop\nchiant sa mere.\n\n\n\n\n\n\n\n\n                    micheline", issued_pc)
   end

   current_pc = pc_list[1]
   pcView = PcView:new(current_pc.issues)

   currentView = mapView


   productivity = 0
   moneyGoal = 100
   currentMoney = 0
   dayDuration = 240 -- seconds
   gameOver = false
end

function _update60()


   if(dt == null) then
      local target_fps = stat(8)
      dt = 1 / target_fps
   end

   t += dt -- in s

   if currentView == mainMenuView then
      if currentView:update(t) == -1 then
	 startDay()
      else
	 return 0
      end
   end



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
   -- printh(t)
   if t > dayDuration then
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
      currentView:draw(t, productivity, currentMoney, moneyGoal, dayDuration, currentDay)
   else
      print("game over", 40, 50, 1)
   end
end
