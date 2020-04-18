PcView = {}

function PcView:new(ticketId)
   local pcView = setmetatable({}, { __index = PcView})

   pcView.ticketId = ticketId
   
   pcView.menus = {}
   add(pcView.menus, DesktopMenu:new())
   add(pcView.menus, SettingsMenu:new())

   i = 0
   for v in all(pcView.menus) do

      if v.id == 0 then
	 pcView.currentMenu = v
      end
      
      i+=1
   end
   
   return pcView
end

function PcView:setCurrentMenu(menuId)
   
   for v in all(self.menus) do
      if v.id == menuId then
	 self.currentMenu = v
      end
   end
   
end
   

function PcView:update()

   self:setCurrentMenu(self.currentMenu:update())
   
end

function PcView:draw(t)
   rectfill(0, 0, 127, 127, 1)
   
   for i=0, 5, 1 do
      rect(i, i, 127-i, 127-i, 6)
   end
   
   rectfill(39, 124, 89, 125, 0)

   self.currentMenu:draw()

end



