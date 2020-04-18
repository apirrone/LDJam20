PcView = {}

function PcView:new(ticketId)
   local pcView = setmetatable({}, { __index = PcView})

   pcView.ticketId = ticketId
   
   pcView.menus = {}
   add(pcView.menus, DesktopMenu:new())

   issues = generateIssues(1)

   monitoringMenu = SettingsMenu:new(MONITORING_MENU_ID)
   monitoringMenu:addSetting("internet status", true, false)
   monitoringMenu:addSetting("hard drive status", true, false)
   monitoringMenu:addSetting("ver num", true, false)
   add(pcView.menus, monitoringMenu)

   settingsMenu = SettingsMenu:new(SETTINGS_MENU_ID)
   settingsMenu:addSetting("enable mouse", true, true)
   settingsMenu:addSetting("enable internet", true, true)
   settingsMenu:addSetting("enable printing", true, true)
   settingsMenu:addSetting("enable register 0x587", true, true)
   settingsMenu:addSetting("enable register 0x473", true, true)
   settingsMenu:addSetting("enable register 0x100", true, true)
   settingsMenu:addSetting("enable register 0x742", true, true)
   add(pcView.menus, settingsMenu)

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
   rectfill(0, 0, 127, 127, 13)
   
   for i=0, 5, 1 do
      rect(i, i, 127-i, 127-i, 6)
   end
   
   rectfill(39, 124, 89, 125, 0)

   self.currentMenu:draw()

end



function generateIssues(nbIssues)
   issues = {}
   issues.physical = {}
   issues.settings = {}
   issues.browser = {}
   issues.virus = {}
   
   for i=0,nbIssues,1 do
      
      issueType = flr(rnd(4)) -- 0 : physical, 1 : settings, 2 : browser, 3: virus
      
      if issueType == 0 then
	 issue = flr(rnd(4)) -- 0 : unplugged keyboard, 1 : unplugged mouse, 2 : unplugged screen, 3 : unplugged ethernet cable
	 add(issues.physical, issue)
      elseif issueType == 1 then
	 issue = flr(rnd(3)) -- 0 : no internet, 1 : hard drive full, 2 : ver. num
	 add(issues.settings, issue)
      elseif issueType == 2 then
	 add(issues.browser, 0) -- 0 : many toolbars
      elseif issueType == 3 then
	 issue = flr(rnd(2)) -- 0 : pron ads, 1 : ransomware, 2 : ????
	 add(issues.virus, issue)
      end
      
   end

   
end
 
