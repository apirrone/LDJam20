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


function is_pc(x,y)
   return fget(mget(x,y), 6)
end

function MapView:scan_pcs()

   pc_list = {}

   for i=0, flr(self.size.w/8) do
      for j=0, flr(self.size.h/8) do
         if(is_pc(i,j)) then
            add(pc_list, {x=i,y=j})
         end
      end
   end

   return pc_list
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

function MapView:can_toggle_pc()
   return self.player:in_front_pc()
end

function MapView:draw(t)
   map(0,0,0,0,self.size.w,self.size.h)
   self.player:draw(t)
   for npc in all(self.NPCs) do
      npc:draw()
   end

   for pc in all(pc_list) do --weird accessing global like that
      if(pc.highlight) then
         rect(pc.pos.x *8,pc.pos.y*8,(pc.pos.x +1)*8,(pc.pos.y + 1)*8,8)
      end
   end
end
