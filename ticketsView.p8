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
   tmp = split(self.text, '\n')[1]
   cropped_text = (self.index + 1)..". "..tmp .. "..."

   color = 7
   if(self.highlighted) then color = 8 end
   if(is_all_ok(self.pc.issues)) then color = 11 end

   print(cropped_text, 6, rowHeight*pos + 9, color)
end

function breakText(text, nbCharsPerLine)
   words = split(text, ' ')
   subStrings = {}

   subString = words[1]
   for i=2, #words, 1 do
      tmp = subString..' '..words[i]
      if #tmp < nbCharsPerLine then
	 subString = subString..' '..words[i]
      else
	 add(subStrings, subString)
	 subString = words[i]
      end
   end
   add(subStrings, subString)

   ret = subStrings[1]..'\n'
   for i=2, #subStrings,1 do
      ret = ret..subStrings[i]..'\n'

   end
   
   return ret
   
end

function split(str,d,dd)
   local a={}
   local c=0
   local s=''
   local tk=''

   if dd~=nil then str=split(str,dd) end
   while #str>0 do
      if type(str)=='table' then
	 s=str[1]
	 add(a,split(s,d))
	 del(str,s)
      else
	 s=sub(str,1,1)
	 str=sub(str,2)
	 if s==d then 
	    add(a,tk)
	    tk=''
	 else
	    tk=tk..s
	 end
      end
   end
   add(a,tk)
   return a
end

function Ticket:draw_full()
   print((self.index + 1)..". "..self.text, 6, 9)
   -- printh(text)
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

   ticketsView.texts = {
      "Hi, my computer is not working. Can you help please ?",
      "Sup guys, my computer stopped working. I don't know what caused it and I have important work to do.",
      "computer broken help required",
      "My mouse thingy doesn't click on the stuff help",
      "altovistron ENTER How to repair computer ENTER How to fix screen ENTER IT phone number ENTER What does IT mean.",
      "Good evening. My machine appears to be in need of a swift repair. Would you be so kind to come help me ?",
      "Hello. Computer is broken again",
      "Hi, I pressed the button that I usually use but this time it didn't work. What did you do ?",
      "hello. my toolbars are not working correctly. can you fix them ?",
      "I can't access the following websites : internet explorator and mozillo firefax",
      "electric thingy no work need repairman",
      "Hello, my internet access is unplugged. Could you update my screen please ?",
      "Hey guys, you won't believe it but I won 1 000 000 dollars ! Anyway, now my computer won't work. Could you help ?",
      "I downloaded more RAM because my PC was slow. Now it doesn't work. Can you help ?",
      "I forgot how to use the keyboard. Please come quickly.",
      "Come help me",
      "Is this the IT department ?",
      "My name is Brigitte. I have a computer.",
      "computer is not working",
      "my monitor is not connected to the world wide web. i think my mouse has caught rabies",
      "Bonjour, mon ordinateur est en panne. J'aurai besoin d'assistance au plus vite.",
      "hey IT guy, come help. Mike sent me a file and now my screen is all weird.",
      "mY cOmPuTeR iS bRoKeN",
      "Hi. I think something is wrong with my personal computer.",
      "YES I HAVE TRIED TURNING IT OFF AND ON AGAIN",
      "I think I disconnected the wide array defumisator and it causes a malfunction of the blockchain permutator",
      "MY NAME IS STEVEN I CAN'T SEND E MAILS",
      "Apparently I have won the lottery !! FUCK YOU GUYS I'LL NEVER COME BACK",
      "Hey dude, what did you do to my computer ? Since you came within 10 meters of my office it started to bug... Come and fix your mistakes...",
      "Haha look at that funny link : www.obviousmalware.com",
      "Haha you will NOT believe how she is dressed !!!! www.ipromiseitsnotphishing.com",
      "Hey guys ! Did you know that computers actually use electricity ? Anyway, it's not working again...",
      "Hello, my computer is not turned on.",
      "Hi, my computer is broken, I have tried everything but it's no help.",
      "cOmPuTeR nO wOrK",
      "I seem to have trouble fixing this electric contraption you installed in my office.",
      "I can't click my icons !!!!!",
      "My program is not loading my files !!!!!!!! HELPPPPP",
      "Hi, I ha-",
      "Sorry guys, broke the thing again. Can you help ?",
   }
   
   return ticketsView
end

function TicketsView:addTicket(pc)
   id = #(self.tickets)
   text = breakText(ticketsView.texts[flr(rnd(#ticketsView.texts))+1], 27)

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
