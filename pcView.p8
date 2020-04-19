NB_PHYSICAL_ISSUES = 4
NB_SETTINGS_ISSUES = 4
NB_MONITORING_ISSUES = 3
NB_BROWSER_ISSUES = 1
NB_VIRUS_ISSUES = 2
TOTAL_NB_ISSUES = NB_PHYSICAL_ISSUES + NB_SETTINGS_ISSUES + NB_MONITORING_ISSUES + NB_BROWSER_ISSUES + NB_VIRUS_ISSUES

PcView = {}

function PcView:new(ticketId, nbIssues)
   local pcView = setmetatable({}, { __index = PcView})

   pcView.ticketId = ticketId

   pcView.allOk = false
   issues = generateIssues(nbIssues)

   
   pcView.menus = {}
   add(pcView.menus, DesktopMenu:new(issues))

   
   pcView:generateMenus(issues)   
   
   
   i = 0
   for v in all(pcView.menus) do

      if v.id == 0 then
	 pcView.currentMenu = v
      end
      
      i+=1
   end
   
   return pcView
end

function PcView:generateMenus(issues)
   
   monitoringMenu = SettingsMenu:new(MONITORING_MENU_ID)
   unpluggedKeyboard = false
   unpluggedMouse    = false
   unpluggedScreen   = false
   unpluggedEthernet = false
   hardDriveFull     = false
   verNumDisabled    = false
   mouseDisabled     = false
   internetDisabled  = false
   printingDisabled  = false
   registerDisabled  = false
   
   i = 0
   for v in all(issues) do
      if v == 0 then
	 if i == 0 then
	    unpluggedKeyboard = true
	 end
	 
	 if i == 1 then
	    unpluggedMouse = true
	 end
	 
	 if i == 2 then
	    unpluggedScreen = true
	 end
	 
	 if i == 3 then
	    unpluggedEthernet = true
	 end

	 if i == 4 then
	    mouseDisabled = true
	 end
	 
	 if i == 5 then
	    internetDisabled = true
	 end
	 
	 if i == 6 then
	    printingDisabled = true
	 end
	 
	 if i == 7 then
	    registerDisabled = true
	 end
	 
	 if i == 9 then
	    hardDriveFull = true
	 end

	 if i == 10 then
	    verNumDisabled = true
	 end
	 
      end
      
      i+=1
   end
   
   monitoringMenu:addSetting("internet status", not unpluggedEthernet, false)
   monitoringMenu:addSetting("hard drive full", not hardDriveFull, false)
   monitoringMenu:addSetting("ver num status", not verNumDisabled, true)
   add(self.menus, monitoringMenu)

   settingsMenu = SettingsMenu:new(SETTINGS_MENU_ID)
   settingsMenu:addSetting("enable mouse", not mouseDisabled, true)
   settingsMenu:addSetting("enable internet", not internetDisabled, true)
   settingsMenu:addSetting("enable printing", not printingDisabled, true)
   settingsMenu:addSetting("enable register 0x587", not registerDisabled, true)
   add(self.menus, settingsMenu)

   cablesMenu = CablesMenu:new()
   cablesMenu:addSetting("unplugged keyboard", not unpluggedKeyboard, true)
   cablesMenu:addSetting("unplugged mouse", not unpluggedMouse, true)
   cablesMenu:addSetting("unplugged screen", not unpluggedScreen, true)
   cablesMenu:addSetting("unplugged ethernet", not unpluggedEthernet, true)

   add(self.menus, cablesMenu)
end

function PcView:setCurrentMenu(menuId)
   
   for v in all(self.menus) do
      if v.id == menuId then
	 self.currentMenu = v
      end
   end
   
end
   

function PcView:update()
   oldMenuId = self.currentMenu.id
   menuId = self.currentMenu:update()
   
   if menuId == -1 then
      return -1
   end
   
   self:setCurrentMenu(menuId)
   if oldMenuId != self.currentMenu.id then

      self.allOk = true
      for v in all(self.menus) do
	 for vv in all(v.settings) do
	    if not vv.status then
	       self.allOk = false
	    end

	 end
      end
   end

   return 1
	 
   
   
end

function PcView:draw(t)
   rectfill(0, 0, 127, 127, 13)
   
   for i=0, 5, 1 do
      rect(i, i, 127-i, 127-i, 6)
   end
   
   rectfill(39, 124, 89, 125, 0)

   self.currentMenu:draw()

   -- TODO DEBUG remove this ============
   if self.allOk then
      print("all is ok", 10, 100)
   else
      print("not all is ok", 10, 100)
   end
   -- ====================================

end



function generateIssues(nbIssues)
   issues = {}

   -- | physical | settings | monitoring | browser | virus|
   --   1 1 1 1    1 1 1 1       1 1 1        1       11
   -- Physical   : unplugged keyboard, unplugged mouse, unplugged screen, unplugged ethernet cable
   -- settings   : enable mouse, enable internet, enable printing, enable register
   -- monitoring : no internet, hard drive full, ver.num
   -- browser    : many toolbars
   -- virus      : pron ads, ransomware
   

   -- total_nb_issues = nb_physical_issues + nb_settings_issues + nb_monitoring_issues + nb_browser_issues + nb_virus_issues

   issues_str = ""
   issuesIndex = {}
   
   for i=0, nbIssues-1, 1 do
      add(issuesIndex, flr(rnd(TOTAL_NB_ISSUES)))
   end

   for i=0, TOTAL_NB_ISSUES, 1 do
      issue = false
      for v in all(issuesIndex) do
	 if i == v then
	    issue = true
	 end
      end
      if issue then
	 add(issues, 0)
	 issues_str = issues_str.."0"
      else
	 add(issues, 1)
	 issues_str = issues_str.."1"
      end
   end
   -- cls()
   -- print(issues_str)
   return issues
   
end
 
