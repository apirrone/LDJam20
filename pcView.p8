NB_PHYSICAL_ISSUES = 4
NB_SETTINGS_ISSUES = 4
NB_MONITORING_ISSUES = 3
NB_BROWSER_ISSUES = 1
NB_VIRUS_ISSUES = 2
TOTAL_NB_ISSUES = NB_PHYSICAL_ISSUES * NB_SETTINGS_ISSUES * NB_MONITORING_ISSUES * NB_BROWSER_ISSUES * NB_VIRUS_ISSUES

PcView = {}

function PcView:new(ticketId, nbIssues)
   local pcView = setmetatable({}, { __index = PcView})

   pcView.ticketId = ticketId
   
   pcView.menus = {}
   add(pcView.menus, DesktopMenu:new())

   pcView:generateMenus(nbIssues)   
   
   i = 0
   for v in all(pcView.menus) do

      if v.id == 0 then
	 pcView.currentMenu = v
      end
      
      i+=1
   end
   
   return pcView
end

function PcView:generateMenus(nbIssues)
   
   issues = generateIssues(nbIssues)
   
   monitoringMenu = SettingsMenu:new(MONITORING_MENU_ID)
   monitoringMenu:addSetting("internet status", true, false)
   monitoringMenu:addSetting("hard drive status", true, false)
   monitoringMenu:addSetting("ver num status", true, false)
   add(self.menus, monitoringMenu)

   settingsMenu = SettingsMenu:new(SETTINGS_MENU_ID)
   settingsMenu:addSetting("enable mouse", true, true)
   settingsMenu:addSetting("enable internet", true, true)
   settingsMenu:addSetting("enable printing", true, true)
   settingsMenu:addSetting("enable register 0x587", true, true)

   add(self.menus, settingsMenu)
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
	 issues_str = issues_str.."0"
      else
	 issues_str = issues_str.."1"
      end
   end

   return issues_str
   
end
 
