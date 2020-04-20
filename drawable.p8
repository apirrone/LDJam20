pico-8 cartridge // http://www.pico-8.com
version 21
__lua__

Drawable = {}

function Drawable:new(x, y, w, h)
	newObj = {}

	newObj.pos = {}
	newObj.pos.x = x
	newObj.pos.y = y
	printh("npc pos: x "..(x or "X").." y "..(y or "X"))

	newObj.size = {}
	newObj.size.w = w
	newObj.size.h = h

	self.__index = self
	return setmetatable(newObj, self)
end



NPC = Drawable:new()

function NPC:new(x,y,w,h,spr_id)
	newObj = Drawable:new(x,y,w,h)
	newObj.spr_id = spr_id

	newObj.orig_pos = {}
	newObj.orig_pos.x = newObj.pos.x
	newObj.orig_pos.y = newObj.pos.y

	self.__index = self
	return setmetatable(newObj, self)
end

function NPC:draw()
	if(self.pos.x == self.orig_pos.x) then
		spr(self.spr_id, self.pos.x, self.pos.y, self.size.w,1)
		spr(129, self.pos.x, self.pos.y+8)
	else
		spr(self.spr_id,self.pos.x,self.pos.y, self.size.w,self.size.h)
	end
end

function NPC:update(mapview)
	pc = mapview.player:in_front_pc()

	if(pc.val and pc.coords.x == (flr(self.orig_pos.x/8) + 1) and pc.coords.y == flr(self.orig_pos.y/8)) then
		self.pos.x = self.orig_pos.x - 8
	else
		self.pos.x = self.orig_pos.x
	end
end