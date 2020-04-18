pico-8 cartridge // http://www.pico-8.com
version 21
__lua__

Drawable = {}

function Drawable:new(x, y, w, h)
	newobj = {}
	self.__index = self

	self.pos = {}
	self.pos.x = x
	self.pos.y = y

	self.size = {}
	self.size.w = w
	self.size.h = h

	return setmetatable(newobj, self)
end

function Drawable:drawrec(x,y)
	rectfill(x,y,x + 50,y + 50, 4)
end
