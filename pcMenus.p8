DESKTOP_MENU_ID    = 0
FILES_MENU_ID      = 1
BROWSER_MENU_ID    = 2
AVAST_MENU_ID      = 3
MONITORING_MENU_ID = 4
SETTINGS_MENU_ID   = 5
CABLES_MENU_ID     = 6

-- ============================================================================================

Icon = {}
function Icon:new(index, x, y, spriteId, spacing)
   local icon = setmetatable({}, { __index = Icon})

   icon.index = index

   icon.spacing = spacing
   
   icon.pos = {}
   icon.pos.x = x*icon.spacing+10
   icon.pos.y = y*icon.spacing+10

   icon.spriteId = spriteId
   return icon

end

function Icon:draw()
   spr(self.spriteId, self.pos.x, self.pos.y, 1, 1)
end

-- ============================================================================================

Cursor = {}

function Cursor:new(x, y, spacing)
   local cursor = setmetatable({}, { __index = Cursor})
   
   cursor.pos = {}
   cursor.pos.x = x
   cursor.pos.y = y
   cursor.spacing = spacing

   currentIndex = 0
   
   return cursor

end


function Cursor:draw()

   tmpX = self.pos.x*self.spacing+10
   tmpY = self.pos.y*self.spacing+10

   
   pset(tmpX, tmpY, 8)
   pset(tmpX+1, tmpY, 8)
   pset(tmpX+2, tmpY, 8)
   pset(tmpX, tmpY+1, 8)
   pset(tmpX, tmpY+2, 8)
   
   pset(tmpX+7, tmpY, 8)
   pset(tmpX+6, tmpY, 8)   
   pset(tmpX+5, tmpY, 8)
   pset(tmpX+7, tmpY+1, 8)
   pset(tmpX+7, tmpY+2, 8)

   
   pset(tmpX, tmpY+7, 8)
   pset(tmpX, tmpY+6, 8)
   pset(tmpX, tmpY+5, 8)
   pset(tmpX+1, tmpY+7, 8)
   pset(tmpX+2, tmpY+7, 8)

   
   pset(tmpX+7, tmpY+7, 8)
   pset(tmpX+6, tmpY+7, 8)
   pset(tmpX+5, tmpY+7, 8)
   pset(tmpX+7, tmpY+6, 8)
   pset(tmpX+7, tmpY+5, 8)   
   
end


-- ============================================================================================


DesktopMenu = {}

function DesktopMenu:new(issues)

   local desktopMenu = setmetatable({}, { __index = DesktopMenu})

   desktopMenu.issues = issues
   desktopMenu.settings = {}   
   desktopMenu.id = DESKTOP_MENU_ID
   desktopMenu.exitState = 0
   desktopMenu.icons = {}

   desktopMenu.spacing = 15
   
   add(desktopMenu.icons, Icon:new(#desktopMenu.icons+1, 0, 0, 192, desktopMenu.spacing)) -- Files
   add(desktopMenu.icons, Icon:new(#desktopMenu.icons+1, 1, 0, 194, desktopMenu.spacing)) -- Browser
   add(desktopMenu.icons, Icon:new(#desktopMenu.icons+1, 2, 0, 202, desktopMenu.spacing)) -- Avast
   add(desktopMenu.icons, Icon:new(#desktopMenu.icons+1, 0, 1, 203, desktopMenu.spacing)) -- Monitoring
   add(desktopMenu.icons, Icon:new(#desktopMenu.icons+1, 1, 1, 206, desktopMenu.spacing)) -- Settings

   desktopMenu.cursor = Cursor:new(0, 0, desktopMenu.spacing)
   
   self.virus = false
   self.unpluggedKeyboard = false
   self.unpluggedMouse = false
   self.unpluggedScreen = false
   return desktopMenu
end

function DesktopMenu:update(issues, t)
   self.issues = issues
   newPos = {}
   newPos.x = self.cursor.pos.x
   newPos.y = self.cursor.pos.y

   selectedMenuId = 0
   self.virus = (self.issues[13] == 0)
   self.unpluggedKeyboard = (self.issues[1] == 0)
   self.unpluggedMouse = (self.issues[2] == 0)
   self.unpluggedScreen = (self.issues[3] == 0)
   
   if (btnp(5)) then -- X
      if (self.exitState == 0) then
	 if (not self.unpluggedScreen and not self.unpluggedKeyboard and not self.unpluggedMouse) then
	    selectedMenuId = self.cursor.currentIndex
	 end
      else
	 self.exitState = 0
	 selectedMenuId = CABLES_MENU_ID
      end
   end


   if (btnp(4)) then -- C
      if self.exitState == 0 then
	 self.exitState = 1
      else
	 self.exitState = 0
	 selectedMenuId = -1
      end
   end
   
   if (not self.unpluggedMouse) and (not self.unpluggedKeyboard) then
      
      if (btnp(⬆️)) then
	 newPos.y -= 1
      elseif (btnp(⬇️)) then
	 newPos.y += 1
      end

      if (btnp(⬅️)) then
	 newPos.x -= 1
      elseif (btnp(➡️)) then
	 newPos.x += 1
      end


      
      tmpIndex = self:isValidPos(newPos.x, newPos.y)
      if tmpIndex then
	 self.cursor.pos = newPos
	 self.cursor.currentIndex = tmpIndex
      end
   end
   
   return selectedMenuId
end


function DesktopMenu:draw(t)

   
   rectfill(6, 109, 121, 121, 5)
   
   if not self.unpluggedScreen then
      for v in all(self.icons) do
	 v:draw()
      end
      
      print("lucarne 98", 82, 103, 2)

      self.cursor:draw()


      if self.virus then
	 print("/!\\ warning !!!\nyour data has been encrypted\nsend money to 0x138c92\nto get decrypt key", 10, 70, 8)
      end
      
      -- print(self.cursor.currentIndex, 0, 0)
      if self.exitState == 0 then
	 print("select : \151", 7, 110, 15)
      end
      print("browse : \148\131\139\145", 7, 116, 15)
   else
      print("NO SIGNAL", 10, 10)
   end

   
   if self.exitState == 1 then
      print("cables : \151", 78, 110, 15)
   end
   print("exit : \142", 86, 116, 15)
end

function DesktopMenu:isValidPos(x, y)
   
   retVal = false
   for v in all(self.icons) do
      if v.pos.x == (x*v.spacing+10) and v.pos.y == (y*v.spacing+10) then
	 retVal = v.index
      end
   end

   return retVal
end


-- ============================================================================================


Setting = {}
function Setting:new(text, iconIndex, status, spacing, togglable, bgColor)
   local setting = setmetatable({}, { __index = Setting})

   setting.text = text
   setting.iconIndex = iconIndex
   setting.status = status

   setting.spacing = spacing
   
   setting.pos = {}
   setting.pos.x = 0*setting.spacing+8
   setting.pos.y = setting.iconIndex*setting.spacing+12

   setting.togglable = togglable
   setting.bgColor = bgColor
   return setting
end
function Setting:generateRandomString()
   string = ""
   for i=0,4,1 do
      string = string..''..flr(rnd(50))
   end
   
   
   return string
end
function Setting:draw(encrypted)
   if self.bgColor != -1 then
      rectfill(self.pos.x-2, self.pos.y-2, 121, self.pos.y+8, self.bgColor)
   end

   if not encrypted then
      print(self.text, self.pos.x, self.pos.y, 9)
   else
      print(self.generateRandomString(), self.pos.x, self.pos.y, 9)
   end
end


-- ============================================================================================



SettingsMenu = {}

function SettingsMenu:new(id)
   local settingsMenu = setmetatable({}, { __index = SettingsMenu})

   settingsMenu.id = id
   
   
   settingsMenu.settings = {}

   settingsMenu.icons = {}

   settingsMenu.spacing = 10

   settingsMenu.cursor = Cursor:new(10, 1, settingsMenu.spacing)
   
   return settingsMenu
   
end

function SettingsMenu:addSetting(text, status, togglable)
   if status then
      add(self.icons, Icon:new(#self.icons+1, 10, #self.icons+1, 205, self.spacing))
   else
      add(self.icons, Icon:new(#self.icons+1, 10, #self.icons+1, 204, self.spacing))
   end
   
   add(self.settings, Setting:new(text, #self.icons, status, self.spacing, togglable, -1))
end

function SettingsMenu:update(issues, t)
   newPos = {}
   newPos.x = self.cursor.pos.x
   newPos.y = self.cursor.pos.y

   selectedMenuId = self.id
   if (btnp(⬆️)) then
      newPos.y -= 1
   elseif (btnp(⬇️)) then
      newPos.y += 1
   end

   if (btnp(⬅️)) then
      selectedMenuId = DESKTOP_MENU_ID
   elseif (btnp(➡️)) then
      newPos.x += 1
   end

   if (btnp(5)) then -- X
      for v in all(self.icons) do
	 if v.index == self.cursor.currentIndex then

	    for vv in all(self.settings) do
	       if vv.iconIndex == v.index then
		  if vv.togglable then
		     vv.status = not vv.status
		  end
	       end
	    end

	 end
      end
   end
   
   
   for v in all(self.icons) do
      i = 1
      for vv in all(self.settings) do
	 if v.index == i then
	    if vv.status then
	       v.spriteId = 205
	    else
	       v.spriteId = 204
	    end
	 end
	 i+=1
      end
   end

   
   tmpIndex = self:isValidPos(newPos.x, newPos.y)
   if tmpIndex then
      self.cursor.pos = newPos
      self.cursor.currentIndex = tmpIndex
   end

   return selectedMenuId
end

function SettingsMenu:draw()
   -- print("settings", 8, 8)
   
   for v in all(self.icons) do
      v:draw()
   end

   for v in all(self.settings) do
      v:draw()
   end
   
   
   rectfill(6, 109, 121, 121, 5)
   
   self.cursor:draw()
   
   print("toggle : \151", 7, 110, 15)
   print("browse : \148\131", 7, 116, 15)
   print("go back : \139", 74, 116, 15)
   
end


function SettingsMenu:isValidPos(x, y)   
   retVal = false
   for v in all(self.icons) do
      if v.pos.x == (x*v.spacing+10) and v.pos.y == (y*v.spacing+10) then
	 retVal = v.index
      end
   end

   return retVal
end

-- ============================================================================================


CablesMenu = {}

function CablesMenu:new()
   local cablesMenu = setmetatable({}, { __index = CablesMenu})
   
   cablesMenu.settings = {}
   cablesMenu.icons = {}
   cablesMenu.id = CABLES_MENU_ID
   cablesMenu.spacing = 15

   cablesMenu.cursor = Cursor:new(4.2, 1, cablesMenu.spacing)
   return cablesMenu
end

function CablesMenu:addSetting(text, status, togglable)
   if status then
      add(self.icons, Icon:new(#self.icons+1, 4.2, #self.icons+1, 209, self.spacing))
   else
      add(self.icons, Icon:new(#self.icons+1, 4.2, #self.icons+1, 208, self.spacing))
   end
   
   add(self.settings, Setting:new(text, #self.icons, status, self.spacing, togglable, -1))
end

function CablesMenu:update(issues, t)
   selectedMenuId = self.id

   newPos = {}
   newPos.x = self.cursor.pos.x
   newPos.y = self.cursor.pos.y

   if (btnp(⬆️)) then
      newPos.y -= 1
   elseif (btnp(⬇️)) then
      newPos.y += 1
   end

   if (btnp(5)) then -- X
      for v in all(self.icons) do
	 if v.index == self.cursor.currentIndex then

	    for vv in all(self.settings) do
	       if vv.iconIndex == v.index then
		  if vv.togglable then
		     vv.status = not vv.status
		  end
	       end
	    end
	 end
      end

      for v in all(self.icons) do
	 i = 1
	 for vv in all(self.settings) do
	    if v.index == i then
	       if vv.status then
		  v.spriteId = 209
	       else
		  v.spriteId = 208
	       end
	    end
	    i+=1
	 end
      end
      
   end
   
   tmpIndex = self:isValidPos(newPos.x, newPos.y)
   if tmpIndex then
      self.cursor.pos = newPos
      self.cursor.currentIndex = tmpIndex
   end

   
   if (btnp(⬅️)) then
      selectedMenuId = DESKTOP_MENU_ID
   end

   return selectedMenuId
end

function CablesMenu:draw()
   rectfill(0, 0, 128, 128, 13)
   rectfill(6, 109, 121, 121, 5)

   line(24, 16, 74, 16, 5)
   line(23, 17, 73, 17, 5)
   line(22, 18, 72, 18, 5)
   line(21, 19, 71, 19, 5)
   
   line(74, 16, 74, 76, 5)   
   line(73, 17, 73, 77, 5)   
   line(72, 18, 72, 78, 5)   
   line(71, 19, 71, 79, 5)
   rectfill(20, 20, 70, 80, 6)
   print("bell", 25, 25, 0)
   print("optitron", 25, 31, 0)
   print("7764", 25, 37, 0)
   
   for v in all(self.icons) do
      v:draw()
   end
   self.cursor:draw()


   
   print("toggle : \151", 7, 110, 15)
   print("browse : \148\131", 7, 116, 15)
   print("go back : \139", 74, 116, 15)
end


function CablesMenu:isValidPos(x, y)   
   retVal = false
   for v in all(self.icons) do
      if v.pos.x == (x*v.spacing+10) and v.pos.y == (y*v.spacing+10) then
	 retVal = v.index
      end
   end


   return retVal
end


-- ============================================================================================


FilesMenu = {}

function FilesMenu:new(hardDriveFull)
   local filesMenu = setmetatable({}, { __index = FilesMenu})
   
   filesMenu.id = FILES_MENU_ID

   
   filesMenu.files = {}
   filesMenu.icons = {}
   filesMenu.spacing = 10

   filesMenu.cursor = Cursor:new(10, 1, filesMenu.spacing)
   filesMenu.fileNames = {
      "importantwork.odt",
      "lun32.dll",
      "dormantmalware.exe",
      "batstrezo.png",
      "document.odt",
      "work.odt",
      "passwords.txt",
      "report.odt",
      "riskmanagement.odt",
      "globalmarketshare.calc",
      "agenda.calc",
      "image.odt",
      "grantproposal.odt",
      "convention.odt",
      "ihatemyboss.odt",
      "birthday.jpg",
      "paris.jpg",
      "bordeaux.jpg",
      "starwars9script.txt",
      "untitled.odt",
      "untitled1.odt",
      "untitled2.odt",
      "untitled3.odt",
      "untitled4.odt",
      "digandbuild.exe",
      "launchcodes.txt",
      "mysecretkink.avi",
      "fireflys02e01.avi",
      "secret-lair.kml",
      "IMG83920.png",
      "IMG83720.png",
      "IMG83920.png",
      "IMG67820.png",
      "IMG83740.png",
      "IMG87420.png",
      "IMG01920.png",
      "halflife3.exe",
      "windsofwinter.ipub",
      "40shadesofgreen.ipub"}

   for i=0,7,1 do
      fileNameIndex = flr(rnd(#filesMenu.fileNames))+1
      filesMenu:addFile(filesMenu.fileNames[fileNameIndex])
   end
   filesMenu.virus = false
   filesMenu.settings = {}
   add(filesMenu.settings, Setting:new("", 1, hardDriveFull, 0, true, -1))
   
   return filesMenu
end

function FilesMenu:update(issues, t)
   selectedMenuId = self.id

   self.virus = (issues[13] == 0)
   
   newPos = {}
   newPos.x = self.cursor.pos.x
   newPos.y = self.cursor.pos.y

   if (btnp(⬆️)) then
      newPos.y -= 1
   elseif (btnp(⬇️)) then
      newPos.y += 1
   end
   
   if (btnp(⬅️)) then
      selectedMenuId = DESKTOP_MENU_ID
   end

   if (btnp(5)) then -- X
      for v in all(self.icons) do
	 if v.index == self.cursor.currentIndex then

	    for vv in all(self.files) do
	       if vv.iconIndex == v.index then
		  if vv.togglable then

		     vv.status = false
		     
		     for vvv in all(self.settings) do
			vvv.status = true
		     end
		  end
	       end
	    end

	 end
      end
   end

   tmpIndex = self:isValidPos(newPos.x, newPos.y)
   if tmpIndex then
      self.cursor.pos = newPos
      self.cursor.currentIndex = tmpIndex
   end   

   return selectedMenuId
end

function FilesMenu:addFile(text)   
   add(self.icons, Icon:new(#self.icons+1, 10, #self.icons+1, 210, self.spacing))
   add(self.files, Setting:new(text, #self.icons, true, self.spacing, true, -1))
end

function FilesMenu:isValidPos(x, y)
   
   retVal = false
   for v in all(self.icons) do
      if v.pos.x == (x*v.spacing+10) and v.pos.y == (y*v.spacing+10) then
	 retVal = v.index
      end
   end

   return retVal
end


function FilesMenu:draw()
   spr(192, 7, 8, 1, 1)
   print("files", 18, 10)
   -- print("press x to run virus scan", 7, 30)


   i = 0
   for v in all(self.files) do
      if v.status then 
	 v:draw(self.virus)
	 j = 0
	 for vv in all(self.icons) do
	    if i == j then
	       vv:draw()
	    end
	    j+=1
	 end
      end
      i += 1
   end
   self.cursor:draw()
   rectfill(6, 109, 121, 121, 5)
   print("suppress : \151", 7, 110, 15)
   print("browse : \148\131", 7, 116, 15)
   print("go back : \139", 74, 116, 15)
end


-- ============================================================================================


BrowserMenu = {}

function BrowserMenu:new(manyToolbars)
   local browserMenu = setmetatable({}, { __index = BrowserMenu})
   
   browserMenu.id = BROWSER_MENU_ID

   self.issues = {}
   browserMenu.settings = {}
   browserMenu.toolbars = {}

   add(browserMenu.settings, Setting:new("", 1, manyToolbars, 1, true, -1))
   
   browserMenu.icons = {}
   browserMenu.spacing = 10

   browserMenu.cursor = Cursor:new(10, 1, browserMenu.spacing)

   browserMenu.toolbarNames = {
      "my super toolbar",
      "safe search toolbar",
      "not a virus toolbar",
      "shopping toolbar",
      "toolbar 2.0",
      "the best toolbar 1995"
   }

   browserMenu.virusNames = {
      "congratulations !!!\nyou are visitor number\n1 000 000\n\nclick here to get your prize",
      "doctors hate him\nclick here to view his\ntechnique !!!",
      "enlarge your appendix\nwith this simple trick\nclick here !!"
   }
   
   browserMenu.virusText = browserMenu.virusNames[flr(rnd(#browserMenu.virusNames))+1]

   if not manyToolbars then
      nbToolbars = flr(rnd(4))+1
      for i=0, nbToolbars, 1 do
	 toolbarNameIndex = flr(rnd(#browserMenu.toolbarNames))+1
	 -- filesMenu:addFile(filesMenu.fileNames[fileNameIndex])
	 browserMenu:addToolbar(browserMenu.toolbarNames[toolbarNameIndex])
      end
   end
   
   self.virus = false
   return browserMenu
end

function BrowserMenu:addToolbar(text)
   
   add(self.icons, Icon:new(#self.icons+1, 10, #self.icons+1, 210, self.spacing))
   add(self.toolbars, Setting:new(text, #self.icons, true, self.spacing, true, 10))
end

function BrowserMenu:update(issues, t)
   selectedMenuId = self.id
   self.issues = issues
   self.virus = (self.issues[13] == 0)
   
   newPos = {}
   newPos.x = self.cursor.pos.x
   newPos.y = self.cursor.pos.y

   if (btnp(⬆️)) then
      newPos.y -= 1
   elseif (btnp(⬇️)) then
      newPos.y += 1
   end
   
   if (btnp(⬅️)) then
      selectedMenuId = DESKTOP_MENU_ID
   end

   if (btnp(5)) then -- X

      for v in all(self.icons) do
	 if v.index == self.cursor.currentIndex then

	    for vv in all(self.toolbars) do
	       if vv.iconIndex == v.index then
		  if vv.togglable then
		     vv.status = false
		     allRemoved = true
		     for aze in all(self.toolbars) do
			if aze.status then
			   allRemoved = false
			end
		     end
		     for vvv in all(self.settings) do
			vvv.status = allRemoved
		     end
		  end
	       end
	    end
	    
	 end
      end
   end

   tmpIndex = self:isValidPos(newPos.x, newPos.y)
   if tmpIndex then
      self.cursor.pos = newPos
      self.cursor.currentIndex = tmpIndex
   end


   return selectedMenuId
end

function BrowserMenu:isValidPos(x, y)
   
   retVal = false
   for v in all(self.icons) do
      if v.pos.x == (x*v.spacing+10) and v.pos.y == (y*v.spacing+10) then
	 retVal = v.index
      end
   end

   return retVal
end


function BrowserMenu:draw(t)

   spr(194, 7, 8, 1, 1)
   print("internet explorator", 18, 10)
   rectfill(6, 18, 121, 121, 7)

   print("alta vistron", 40, 72, 1)
   rectfill(30, 80, 95, 85, 0)
   rectfill(31, 81, 94, 84, 7)


   i = 0
   for v in all(self.toolbars) do
      if v.status then 
	 v:draw()
	 j = 0
	 for vv in all(self.icons) do
	    if i == j then
	       vv:draw()
	    end
	    j+=1
	 end
      end
      i += 1
   end

   allRemoved = true
   for aze in all(self.toolbars) do
      if aze.status then
	 allRemoved = false
      end
   end
   if not allRemoved then
      self.cursor:draw()
   end


   if virus then
      print(self.virusText, 25-((t/100)%30), 70-((t/100)%30), 8)
   end
   
   rectfill(6, 109, 121, 121, 5)
   print("suppress : \151", 7, 110, 15)
   print("browse : \148\131", 7, 116, 15)
   print("go back : \139", 74, 116, 15)
end



-- ============================================================================================


AvastMenu = {}

function AvastMenu:new(virus)
   local avastMenu = setmetatable({}, { __index = AvastMenu})
   
   avastMenu.id = AVAST_MENU_ID

   avastMenu.settings = {}
   avastMenu.scanning = false
   avastMenu.scanStartTime = 0
   add(avastMenu.settings, Setting:new("", 0, virus, 0, true, -1))
   return avastMenu
end

function AvastMenu:update(issues, t)
   selectedMenuId = self.id
   
   if (btnp(⬅️)) then
      selectedMenuId = DESKTOP_MENU_ID
   end

   if (btnp(5) and not self.scanning) then -- X
      self.scanning = true
      self.scanStartTime = t
   end

   if (t - self.scanStartTime > 2000) then
      self.scanning = false
      for v in all(self.settings) do
	 v.status = true
      end
   end
   
   return selectedMenuId
end


function AvastMenu:draw(t)
   spr(202, 7, 8, 1, 1)
   print("avost", 18, 10)
   print("press x to run virus scan", 7, 30)

   if self.scanning then
      print("scanning, please wait ...", 15, 50)
   end
   
   rectfill(6, 109, 121, 121, 5)
   print("scan : \151", 7, 116, 15)
   print("go back : \139", 74, 116, 15)
end
