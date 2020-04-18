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

   selector.pos = {}
   
   return ticket
end

-- =================================================================
-- =================================================================
-- =================================================================
-- En vrai il faudrait faire de l'héritage avec la classe view, mais j'ai la flemme de chercher comment faire. Todo à celui qui a la foi

TicketsView = {}

function TicketsView:new()
   local ticketsView = setmetatable({}, { __index = TicketsView})

   ticketsView.tickets = {}
   
   return ticketsView
end

function TicketsView:addTicket(ticket)
   add(self.tickets, ticket)
end

function TicketsView:update()
   
end

function TicketsView:draw(t)
   rectfill(8, 8, 120, 120, 13)
   rect(9, 9, 119, 119, 5)
   rect(10, 10, 118, 118, 15)
   rect(11, 11, 117, 117, 4)
end

