View = {}

function View:new()
   local view = setmetatable({}, { __index = View})

   view.components = {}
   
   return view
end

function View:addComponent(component)
   add(self.components, component)
end

function View:update()
   for component in all(self.components) do
      component:update()
   end
end

function View:draw(t)
   for component in all(self.components) do
      component:draw(t)
   end   
end

