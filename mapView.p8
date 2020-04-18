pico-8 cartridge // http://www.pico-8.com
version 20
__lua__

MapView = {}

function MapView:new(player)
   local mapView = setmetatable({}, { __index = MapView})

   mapView.player = player
   mapView.NPCs = {}

   return mapView
end

function MapView:addNPC(npc)
   add(self.NPCs, npc)
end

function MapView:update()
   self.player:update()
   for npc in all(self.NPCs) do
      npc:update()
   end
end

function MapView:draw(t)

   map(0,0,0,0,200,200)
   self.player:draw(t)
   for npc in all(self.NPCs) do
      npc:draw()
   end
end
