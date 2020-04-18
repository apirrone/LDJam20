Ticket = {}

function Ticket:new(text)
   local ticket = setmetatable({}, { __index = Ticket})

   ticket.text = text
   
   return ticket
end


-- =================================================================
-- =================================================================
-- =================================================================

Selector = {}

function Selector:new(pos)
   local selector = setmetatable({}, { __index = Selector})

   selector.pos      = pos
   selector.h        = 15
   selector.w        = 119
   selector.x_offset = 4
   selector.y_offset = 4
   
   return selector
end

function Selector:draw()
   rect(self.x_offset, self.y_offset+(self.h*self.pos), self.x_offset + self.w, self.y_offset+(self.h*self.pos) + self.h, 9)
end

-- =================================================================
-- =================================================================
-- =================================================================
-- En vrai il faudrait faire de l'héritage avec la classe view, mais j'ai la flemme de chercher comment faire. Todo à celui qui a la foi

TicketsView = {}
released = true
function TicketsView:new()
   local ticketsView = setmetatable({}, { __index = TicketsView})

   ticketsView.tickets = {}
   ticketsView.selector = Selector:new(0)

   return ticketsView
end

function TicketsView:addTicket(ticket)
   add(self.tickets, ticket)
end

function TicketsView:update()
   
   if (btn(⬆️)) then
      if (self.selector.pos > 0 and released) then
	 self.selector.pos -= 1
      end
      released = false
   elseif (btn(⬇️)) then
      if (self.selector.pos < 7 and released) then
	 self.selector.pos += 1
      end
      released = false
   else
      released = true
   end
   
end

function TicketsView:draw(t)
   rectfill(0, 0, 127, 127, 1)
   rect(1, 1, 126, 126, 5)
   rect(2, 2, 125, 125, 15)

   self.selector:draw()
end

