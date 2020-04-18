rowHeight = 15

Ticket = {}

function Ticket:new(text, index)
   local ticket = setmetatable({}, { __index = Ticket})

   ticket.text = text
   ticket.index = index
   
   return ticket
end

function Ticket:draw_cropped()
   cropped_text = sub(self.text, 0, 25) .. "..."
   
   print(cropped_text, 6, rowHeight*self.index + 9)
end

function Ticket:draw_full()
   print(self.text, 6, 9)
end


-- =================================================================
-- =================================================================
-- =================================================================

Selector = {}

function Selector:new(pos)
   local selector = setmetatable({}, { __index = Selector})

   selector.pos      = pos
   selector.h        = rowHeight
   selector.w        = 121
   selector.x_offset = 3
   selector.y_offset = 3
   
   return selector
end

function Selector:draw()
   rect(self.x_offset, self.y_offset+(self.h*self.pos), self.x_offset + self.w, self.y_offset+(self.h*self.pos) + self.h, 9)
end

-- =================================================================
-- =================================================================
-- =================================================================

TicketsView = {}
released = true
function TicketsView:new()
   local ticketsView = setmetatable({}, { __index = TicketsView})
   
   ticketsView.tickets = {}
   ticketsView.selector = Selector:new(0)
   ticketsView.displayState = 0 -- 0 : list, 1 : full message
   return ticketsView
end

function TicketsView:addTicket(text)
   ticket = Ticket:new(text, #(self.tickets))
   add(self.tickets, ticket)
end

function TicketsView:removeTicket(index)
   del(self.tickets, index)
   -- TODO décaler les ids suivants vers la gauche
end

function TicketsView:update()
   
   if (btn(⬆️)) then
      if (self.selector.pos > 0 and released) then
	 self.selector.pos -= 1
      end
      released = false
   elseif (btn(⬇️)) then
      if (self.selector.pos < #self.tickets-1 and released) then
	 self.selector.pos += 1
      end
      released = false
   else
      released = true
   end

   if (btn(⬅️)) then -- show full message
      self.displayState = 0      
   elseif (btn(➡️)) then
      self.displayState = 1
   end
   
   
end

function TicketsView:draw(t)
   rectfill(0, 0, 127, 127, 1)
   rect(1, 1, 126, 126, 5)
   rect(2, 2, 125, 125, 15)

   
   if (self.displayState == 0) then

      for t in all(self.tickets) do
	 t:draw_cropped()
      end
   
      self.selector:draw()
      
      print("see full ticket : \145", 44, 118, 15)
   else

      for t in all(self.tickets) do
	 if t.index == self.selector.pos then
	    t:draw_full()
	 end
      end
      
      print("go back : \139", 76, 118, 15)
   end

end

