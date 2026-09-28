local Layout = require("src.ui.core.layout")

---@class Grid: Layout
---@field cols integer
---@field padding integer
local Grid = setmetatable({}, Layout)
Grid.__index = Grid

---@class ChildSpec.gridOpts
---@field span integer columns child should span

---@param cols integer
---@param children? ChildSpec[]
---@return Grid
function Grid.new(cols, children, padding)
   ---@class Layout
   local self = Layout.new()
   self.cols = cols
   self.padding = padding or 0
   if children then self.children = children end

   return setmetatable(self, Grid)
end

local update_layout = function(self)
   if #self.children == 0 then return end

   local divx = self.w / self.cols
   local rows = math.ceil(#self.children / self.cols)
   local divy = self.h / rows

   local child = 1

   local x = 1
   for i = 1, rows, 1 do
      for j = 1, self.cols, 1 do
         if child > #self.children then break end

         local c = self.children[child]
         local copts = c.opts or {}
         local span = copts.span or 1
         if span > self.cols then span = self.cols end

         local padding_inner = self.padding / 2
         local padding_t, padding_r, padding_b, padding_l =
            self.padding, self.padding, self.padding, self.padding

         if i == rows then padding_b = self.padding * 2 end
         if x == self.cols then padding_r = self.padding * 2 end

         c.child.x = self.x + (divx * (x - 1)) + padding_l
         c.child.y = self.y + (divy * (i - 1)) + padding_t
         c.child.w = (divx * span) - padding_r
         c.child.h = divy - padding_b

         child = child + 1
         x = x + span
         if x > self.cols then x = 1 end
      end
   end
end

function Grid:update(dt)
   update_layout(self)
   for _, c in ipairs(self.children) do
      if c.child.update then c.child:update(dt) end
   end
end

return Grid
