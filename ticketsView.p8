pico-8 cartridge // http://www.pico-8.com
version 16
__lua__


rowHeight = 15

Ticket = {}

function generate_issues_string(issues)
   str = ""
   for v in all(issues) do
      str = str..v
   end

   return str
end


function Ticket:new(text, index, pc)
   local ticket = setmetatable({}, { __index = Ticket})

   ticket.text = text
   ticket.index = index
   ticket.pc = pc
   ticket.highlighted = false

   return ticket
end

function Ticket:draw_cropped(pos)
   cropped_text = (self.index + 1)..". "..sub(self.text, 0, 23) .. "..."

   color = 7
   if(self.highlighted) then color = 8 end
   if(is_all_ok(self.pc.issues)) then color = 11 end

   print(cropped_text, 6, rowHeight*pos + 9, color)
end

function Ticket:draw_full()
   print((self.index + 1)..". "..self.text.."\n"..generate_issues_string(self.pc.issues), 6, 9)
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
   page_offset = self.pos%7
   rect(self.x_offset, self.y_offset+(self.h*page_offset), self.x_offset + self.w, self.y_offset+(self.h*page_offset) + self.h, 9)
end

-- =================================================================
-- =================================================================
-- =================================================================

TicketsView = {}
function TicketsView:new()
   local ticketsView = setmetatable({}, { __index = TicketsView})

   ticketsView.tickets = {}
   ticketsView.selector = Selector:new(0)
   ticketsView.displayState = 0 -- 0 : list, 1 : full message
   return ticketsView
end

function TicketsView:addTicket(text, pc)
   id = #(self.tickets)
   ticket = Ticket:new(text, id, pc)
   add(self.tickets, ticket)
   return id
end

function TicketsView:removeTicket(ticket)
   ticket.pc.highlight = false
   del(self.tickets, ticket)
   -- TODO décaler les ids suivants vers la gauche
end

function TicketsView:update_tickets()
   for t in all(self.tickets) do
      if(is_all_ok(t.pc.issues)) then
         self:removeTicket(t)
      end
   end
end

function TicketsView:update()

   if(#self.tickets > 0) then
      if (btnp(⬆️)) then
         if (self.selector.pos > 0) then
            self.selector.pos -= 1
         end
      elseif (btnp(⬇️)) then
         if (self.selector.pos < #self.tickets-1) then
            self.selector.pos += 1
         end
      end

      if (btnp(⬅️)) then -- show full message
         self.displayState = 0
      elseif (btnp(➡️)) then
         self.displayState = 1
      end

      if(btnp(5)) then
         ticket = self.tickets[self.selector.pos + 1]
         if(is_all_ok(ticket.pc.issues)) then
            self:removeTicket(ticket)
         else
            ticket.highlighted = not ticket.highlighted
            ticket.pc.highlight = ticket.highlighted
         end
      end

   end

   if(btnp(4)) then
      return -1
   end


end

function TicketsView:draw(t)
   rectfill(0, 0, 127, 127, 1)
   rect(1, 1, 126, 126, 5)
   rect(2, 2, 125, 125, 15)

   if(#self.tickets == 0) then
      print("DAY IS OVER GO WATCH NETFLIX", 6, 61, color)
   else
      if (self.displayState == 0) then
         page_size = 7
         first_t = flr(self.selector.pos /page_size) *page_size + 1

         for i = first_t, min(first_t + 6, #self.tickets) do
            t = self.tickets[i]
            t:draw_cropped((i-1)%page_size)
         end

         self.selector:draw()

         print("full ticket : \145", 5, 118, 15)
         print("select : \151", 80, 112, 15)
         print("exit : \142", 88, 118, 15)
      else

         self.tickets[self.selector.pos + 1]:draw_full()

         print("browse : \148\131", 5, 118, 15)
         print("go back : \139", 76, 118, 15)
      end
   end

end
