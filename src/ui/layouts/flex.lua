local Layout = require("src.ui.core.layout")

---@class Flex: Layout
---@field padding integer
local Flex = setmetatable({}, Layout)
Flex.__index = Flex

---@class ChildSpec.flexOpts

---@param children? ChildSpec[]
---@return Flex
function Flex.new(children, padding)
   ---@class Layout
   local self = Layout.new()
   self.padding = padding or 0
   if children then self.children = children end

   return setmetatable(self, Flex)
end

local update_layout = function(self)
   if #self.children == 0 then return end

   local row_height = 0
   local x_prev, y_prev = self.x + self.padding, self.y + self.padding

   for i, child in ipairs(self.children) do
      local c = child.child

      local copts = c.opts or {}

      if (y_prev + self.padding + c.h) > row_height then
         row_height = y_prev + self.padding + c.h
      end
      if (x_prev + self.padding + c.w) > self.w then
         x_prev = self.x + self.padding
         y_prev = row_height + self.padding
      end

      c.x = x_prev + self.padding
      c.y = y_prev + self.padding
      x_prev = x_prev + (self.padding * 2) + c.w
   end
end

function Flex:update(dt)
   update_layout(self)
   for _, c in ipairs(self.children) do
      if c.child.update then c.child:update(dt) end
   end
end

return Flex
