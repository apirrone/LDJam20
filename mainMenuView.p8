MainMenuView = {}

function MainMenuView:new()
   local mainMenuView = setmetatable({}, { __index = MainMenuView})

   
   mainMenuView.traveling = 0
   mainMenuView.direction = 1
   return mainMenuView
end

function MainMenuView:update(t)

   if btnp(5) then
      return -1
   end

   return 0
end

function MainMenuView:draw(t)
   rectfill(self.traveling, 0, self.traveling+128, 128, 1)
   spr(8, self.traveling+36, 3, 8, 4)
   
   -- print("keep i.t. alive")
   if flr(t)%2 ==0 then
      print("press \151 to start", self.traveling+30, 38, 0)
   end
   map(0,0,0,50,100,100)

   camera(self.traveling, 0)
   if self.traveling > 200 or self.traveling < 0 then
      self.direction = - self.direction
   end

   self.traveling = self.traveling+self.direction
   
   spr(32, 20, 60, 1, 2)
   spr(64, 50, 90, 1, 2)
   spr(96, 95, 66, 1, 2)
   
   spr(96, 195, 66, 1, 2)
   spr(64, 150, 90, 1, 2)
   spr(32, 120, 60, 1, 2)
   
   spr(96, 210, 60, 1, 2)
   spr(32, 295, 66, 1, 2)
   spr(64, 250, 90, 1, 2)
end
