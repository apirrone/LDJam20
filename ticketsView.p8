rowHeight = 15

Ticket = {}

function Ticket:new(text, index)
   local ticket = setmetatable({}, { __index = Ticket})

   ticket.text = text
   ticket.index = index
   
   return ticket
end

function Ticket:draw()
   print(self.text, 6, rowHeight*self.index + 9)
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
-- En vrai il faudrait faire de l'héritage avec la classe view, mais j'ai la flemme de chercher comment faire. Todo à celui qui a la foi

TicketsView = {}
released = true
function TicketsView:new()
   local ticketsView = setmetatable({}, { __index = TicketsView})
   
   ticketsView.tickets = {}
   ticketsView.selector = Selector:new(0)

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
   
end

function TicketsView:draw(t)
   rectfill(0, 0, 127, 127, 1)
   rect(1, 1, 126, 126, 5)
   rect(2, 2, 125, 125, 15)


   for t in all(self.tickets) do
      t:draw()
   end
   
   self.selector:draw()

end

