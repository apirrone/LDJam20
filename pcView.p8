pico-8 cartridge // http://www.pico-8.com
version 21
__lua__

PC = {}

function PC:new(x,y, nbIssues)
   local pc = setmetatable({}, { __index = PC})

   pc.pos = {}
   pc.pos.x = x
   pc.pos.y = y

   pc.issues = generateIssues(nbIssues)
   pc.highlight = false
   return pc
end


NB_PHYSICAL_ISSUES = 4
NB_SETTINGS_ISSUES = 3
NB_MONITORING_ISSUES = 4
NB_BROWSER_ISSUES = 1
NB_VIRUS_ISSUES = 1
TOTAL_NB_ISSUES = NB_PHYSICAL_ISSUES + NB_SETTINGS_ISSUES + NB_MONITORING_ISSUES + NB_BROWSER_ISSUES + NB_VIRUS_ISSUES

PcView = {}

function PcView:new(issues)
   local pcView = setmetatable({}, { __index = PcView})

   PcView:loadIssues(issues, true)

   return pcView
end

function PcView:loadIssues(issues, start)
   -- if not start then
   --    sfx(0)
   -- end
   self.issues = issues --generateIssues(nbIssues)

   self.menus = {}
   add(self.menus, DesktopMenu:new(self.issues))

   self:generateMenus()


   self.allOk = true
   for v in all(self.menus) do
      for vv in all(v.settings) do
	 if not vv.status then
	    self.allOk = false
	 end
      end
   end


   i = 0
   for v in all(self.menus) do

      if v.id == 0 then
	 self.currentMenu = v
      end

      i+=1
   end

end

function PcView:generateMenus()

   -- WARNING indexed starting 1
   unpluggedKeyboard = (self.issues[1] == 0)
   unpluggedMouse    = (self.issues[2] == 0)
   unpluggedScreen   = (self.issues[3] == 0)
   unpluggedEthernet = (self.issues[4] == 0)

   mouseDisabled     = (self.issues[5] == 0)
   printingDisabled  = (self.issues[6] == 0)
   registerDisabled  = (self.issues[7] == 0)
   
   hardDriveFull     = (self.issues[9] == 0)
   verNumDisabled    = (self.issues[10] == 0)
   hardDriveFull     = (self.issues[11] == 0)
   manyToolbars      = (self.issues[12] == 0)
   virus             = (self.issues[13] == 0)


   cablesMenu = CablesMenu:new()
   cablesMenu:addSetting("unplugged keyboard", not unpluggedKeyboard, true)
   cablesMenu:addSetting("unplugged mouse", not unpluggedMouse, true)
   cablesMenu:addSetting("unplugged screen", not unpluggedScreen, true)
   cablesMenu:addSetting("unplugged ethernet", not unpluggedEthernet, true)
   add(self.menus, cablesMenu)

   settingsMenu = SettingsMenu:new(SETTINGS_MENU_ID)
   settingsMenu:addSetting("enable mouse", not mouseDisabled, true)
   settingsMenu:addSetting("enable printing", not printingDisabled, true)
   settingsMenu:addSetting("enable register 0x587", not registerDisabled, true)
   add(self.menus, settingsMenu)

   monitoringMenu = SettingsMenu:new(MONITORING_MENU_ID)
   monitoringMenu:addSetting("internet status", not unpluggedEthernet, false)
   monitoringMenu:addSetting("hard drive full", not hardDriveFull, false)
   monitoringMenu:addSetting("ver num status", not verNumDisabled, true)
   add(self.menus, monitoringMenu)

   filesMenu = FilesMenu:new(not hardDriveFull)
   add(self.menus, filesMenu)

   browserMenu = BrowserMenu:new(not manyToolbars)
   add(self.menus, browserMenu)

   avastMenu = AvastMenu:new(not virus)
   add(self.menus, avastMenu)

end

function PcView:setCurrentMenu(menuId)

   for v in all(self.menus) do
      if v.id == menuId then
	 self.currentMenu = v
      end
   end

end


function PcView:update(t)
   oldMenuId = self.currentMenu.id
   menuId = self.currentMenu:update(self.issues, t)

   if menuId == -1 then
      return -1
   end

   self:setCurrentMenu(menuId)
   if oldMenuId != self.currentMenu.id then
      reconstructedIssues = {}
      self.allOk = true
      for v in all(self.menus) do
	 for vv in all(v.settings) do
	    if vv.status then
	       add(reconstructedIssues, 1)
	    else
	       add(reconstructedIssues, 0)
	    end
	    if not vv.status then
	       self.allOk = false
	    end
	 end
      end


      self.issues = reconstructedIssues
      
      ethernetUnPlugged = (self.issues[4] == 0)
      hardDriveFull     = (self.issues[11] == 0)
      virus             = (self.issues[13] == 0)

      i = 0
      for v in all(self.menus) do

      	 if i == 3 then -- monitoringMenu
      	    j = 0
      	    for vv in all(v.settings) do

      	       if j == 0 then
      		  vv.status = not ethernetUnPlugged
      	       end

	       if j == 1 then
      		  vv.status = not hardDriveFull
      	       end
      	       j+=1
      	    end
      	 end
      	 i += 1
      end


      if not hardDriveFull then
	 self.issues[9] = 1
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

   self.currentMenu:draw(t)

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
   --   1 1 1 1    1 1 1       1 1 1   (1)     1       1
   -- Physical   : unplugged keyboard, unplugged mouse, unplugged screen, unplugged ethernet cable
   -- settings   : enable mouse, enable printing, enable register
   -- monitoring : no internet, hard drive full, ver.num, hard drive full (don't ask)
   -- browser    : many toolbars
   -- virus      : pron ads, ransomware (one setting, running avast clears it)


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
      else
	 add(issues, 1)
      end
   end

   return issues
end
