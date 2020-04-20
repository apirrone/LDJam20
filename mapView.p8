pico-8 cartridge // http://www.pico-8.com
version 20
__lua__

MapView = {}

function MapView:new(player)
   local mapView = setmetatable({}, { __index = MapView})

   mapView.player = player
   mapView.NPCs = {}
   mapView.size = {w = 60 * 8, h = 25  * 8} -- TODO: use definitive size
   mapView.productivity = 0
   mapView.pc_list = mapView:scan_pcs()


   npcs_sprs = { 32, 96}
   for pc in all(mapView.pc_list) do
      npc_id = flr(rnd(#npcs_sprs)) + 1
      spr_id = npcs_sprs[npc_id]
      npc = NPC:new((pc.pos.x - 1)*8, pc.pos.y*8, 1, 2, spr_id)
      mapView:addNPC(npc)
   end

   return mapView
end

function MapView:addNPC(npc)
   add(self.NPCs, npc)
end


function is_pc(x,y)
   return fget(mget(x,y), 6)
end

function MapView:scan_pcs()

   local pc_list = {}

   for i=0, flr(self.size.w/8) do
      for j=0, flr(self.size.h/8) do
         if(is_pc(i,j)) then
            add(pc_list, PC:new(i, j, 0))
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

function MapView:update(t)
   if t >= 2 then
      self.player:update(self)

      for npc in all(self.NPCs) do
	      npc:update(self)
      end
      self:updateCamera()
   end
end

function MapView:can_toggle_pc()
   return self.player:in_front_pc()
end

function MapView:draw(t, productivity, currentMoney, moneyGoal, dayDuration, currentDay)
   if t < 2 then
      camera(0, 0)
      print("day "..currentDay, 55, 50, 1)
   else

      map(0,0,0,0,self.size.w,self.size.h)
      for npc in all(self.NPCs) do
         npc:draw()
      end
      self.player:draw(t)

      for pc in all(self.pc_list) do --weird accessing global like that
         if(pc.highlight) then
            color = 8
            if(is_all_ok(pc.issues)) then color = 11 end

            rect(pc.pos.x *8,pc.pos.y*8,(pc.pos.x +1)*8,(pc.pos.y + 1)*8,color)
         end
      end

      camX = self.player.pos.x - 64;
      camY = self.player.pos.y - 64;

      camX = min(max(camX,0), self.size.w - 64)
      camY = min(max(camY,0), self.size.h - 64)

      rectfill(camX+0, camY+100, camX+128, camY+107, 2)
      rectfill(camX+0, camY+100, camX+min(flr(((t)/(dayDuration))*128), 128), camY+107, 3)
      print("day "..currentDay, camX+1, camY+101, 0)
      print("time", camX+112, camY+101, 0)

      rectfill(camX+0, camY+107, camX+128, camY+114, 2)
      rectfill(camX+0, camY+107, camX+flr((currentMoney/moneyGoal)*128), camY+114, 3)
      print("money", camX+1, camY+108, 0)

      rectfill(camX+0, camY+114, camX+128, camY+120, 8)
      rectfill(camX+0, camY+114, camX+flr(productivity*128), camY+120, 3)
      print("productivity bar", camX+1, camY+115, 0)

      rectfill(camX+0, camY+121, camX+128, camY+128, 5)
      print("show tickets:\142", camX+1, camY+122, 15)
      print("interact:\151", camX+84, camY+122, 15)
   end
end
