DESKTOP_MENU_ID    = 0
FILES_MENU_ID      = 1
BROWSER_MENU_ID    = 2
AVAST_MENU_ID      = 3
MONITORING_MENU_ID = 4
SETTINGS_MENU_ID   = 5

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

function DesktopMenu:new()

   local desktopMenu = setmetatable({}, { __index = DesktopMenu})

   desktopMenu.id = DESKTOP_MENU_ID
   
   desktopMenu.icons = {}

   desktopMenu.spacing = 15
   
   add(desktopMenu.icons, Icon:new(#desktopMenu.icons+1, 0, 0, 192, desktopMenu.spacing)) -- Files
   add(desktopMenu.icons, Icon:new(#desktopMenu.icons+1, 1, 0, 194, desktopMenu.spacing)) -- Browser
   add(desktopMenu.icons, Icon:new(#desktopMenu.icons+1, 2, 0, 202, desktopMenu.spacing)) -- Avast
   add(desktopMenu.icons, Icon:new(#desktopMenu.icons+1, 0, 1, 203, desktopMenu.spacing)) -- Settings

   
   -- add(desktopMenu.icons, Icon:new(#desktopMenu.icons+1, 1, 0, 193, spacing))
   -- add(desktopMenu.icons, Icon:new(#desktopMenu.icons+1, 0, 1, 198, spacing))
   -- add(desktopMenu.icons, Icon:new(#desktopMenu.icons+1, 1, 1, 199, spacing))
   -- add(desktopMenu.icons, Icon:new(#desktopMenu.icons+1, 2, 1, 200, spacing))

   desktopMenu.cursor = Cursor:new(0, 0, desktopMenu.spacing)

   
   return desktopMenu
end

function DesktopMenu:update()
   newPos = {}
   newPos.x = self.cursor.pos.x
   newPos.y = self.cursor.pos.y

   selectedMenuId = 0   
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

   if (btnp(5)) then -- X
      selectedMenuId = self.cursor.currentIndex
   end
   
   tmpIndex = self:isValidPos(newPos.x, newPos.y)
   if tmpIndex then
      self.cursor.pos = newPos
      self.cursor.currentIndex = tmpIndex
   end

   return selectedMenuId
end


function DesktopMenu:draw()
   for v in all(self.icons) do
      v:draw()
   end
   
   rectfill(6, 109, 121, 121, 5)

   print("lucarne 98", 82, 103, 2)

   self.cursor:draw()
   print(self.cursor.currentIndex, 0, 0)
   
   print("select : \151", 7, 110, 15)
   print("browse : \148\131\139\145", 7, 116, 15)
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
function Setting:new(text, iconIndex, status, spacing, togglable)
   local setting = setmetatable({}, { __index = Setting})

   setting.text = text
   setting.iconIndex = iconIndex
   setting.status = status

   setting.spacing = spacing
   
   setting.pos = {}
   setting.pos.x = 0*setting.spacing+8
   setting.pos.y = setting.iconIndex*setting.spacing+12

   setting.togglable = togglable
   
   return setting
end

function Setting:draw()
   print(self.text, self.pos.x, self.pos.y, 9)
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
   
   add(self.settings, Setting:new(text, #self.icons, status, self.spacing, togglable))
end

function SettingsMenu:update()
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
		     	    
		     if v.spriteId == 204 then
			v.spriteId = 205
		     else
			v.spriteId = 204
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

function SettingsMenu:draw()
   print("settings", 8, 8)
   
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
