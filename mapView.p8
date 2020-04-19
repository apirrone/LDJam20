pico-8 cartridge // http://www.pico-8.com
version 20
__lua__

MapView = {}

function MapView:new(player)
   local mapView = setmetatable({}, { __index = MapView})

   mapView.player = player
   mapView.NPCs = {}
   mapView.size = {w = 60 * 8, h = 25  * 8} -- TODO: use definitive size

   return mapView
end

function MapView:addNPC(npc)
   add(self.NPCs, npc)
end

function MapView:updateCamera()
   //camera() parameters take left top corner
   camX = self.player.pos.x - 64;
   camY = self.player.pos.y - 64;

   camX = min(max(camX,0), self.size.w - 64)
   camY = min(max(camY,0), self.size.h - 64)

   camera(camX, camY)
end

function MapView:update()
   self.player:update(self)
   for npc in all(self.NPCs) do
      npc:update()
   end

   self:updateCamera()
end

function MapView:toggle_pc()
   return btnp(5) and self.player:in_front_pc()
end

function MapView:draw(t)

   map(0,0,0,0,200,200)
   self.player:draw(t)
   for npc in all(self.NPCs) do
      npc:draw()
   end
end
